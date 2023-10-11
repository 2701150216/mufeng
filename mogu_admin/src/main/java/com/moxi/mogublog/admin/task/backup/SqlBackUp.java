package com.moxi.mogublog.admin.task.backup;

import com.qiniu.common.Zone;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.FileListing;
import com.qiniu.util.Auth;
import lombok.extern.slf4j.Slf4j;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Component
@Slf4j
public class SqlBackUp {

    static String uploadToken = null;//牛哥的上传令牌
    static String bakZipFilePath = null;// 压缩的备份文件全路径
    static String fileName7qZip = null;//上传到牛哥空间的唯一文件名
    static Auth auth = null;//牛哥授权
    static String bakRootPath;//备份文件 的根目录
    static Configuration cfg = new Configuration(Zone.zone2());
    @Value("${data.task.backup.sql.num:240}")
    static int maxFileNum = 240;
    /**
     * 初始化
     */
    private static void init() {
        try {
            auth = Auth.create("XHDYw0p1ilTDqoSg3nJKepOMQ5Dne8CJe33tn5J3", "PUc9u3LOF5FGlBINPd5L2Dnohi1Uj8_dosllkGMP");
            uploadToken = auth.uploadToken("mufengobs");
            bakRootPath = isWindows() ? "D:\\tmp\\mysql_backup" : "/tmp/mysql_backup";
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean isLinux() {
        return System.getProperty("os.name").toLowerCase().contains("linux");
    }

    public static boolean isWindows() {
        return System.getProperty("os.name").toLowerCase().contains("windows");
    }

    @Scheduled(initialDelay = 10 * 1000, fixedDelay = 60 * 60 * 1000)
    public static void BackUpSql() {
        init();
        try {
            if (null == uploadToken) {
                init();
            } else {
                if (null == bakZipFilePath) {
                    getMysqlBak();
                }

                UploadManager uploadManager = new UploadManager(cfg);
                if (!isWindows()) {
                    uploadManager.put(new File(bakZipFilePath), fileName7qZip, uploadToken);
                    log.info("7牛云上传成功：{}", fileName7qZip);
                }

                bakZipFilePath = null;
                //删除7牛上前30份的备份
                try {
                    BucketManager bucketManager = new BucketManager(auth, cfg);
                    String bucket = "mufengobs";
                    String prefix = "mysqlBackup";
                    String delimiter = "";
                    int limit = 1000;
                    FileListing fileListing = bucketManager.listFilesV2(bucket, prefix, "", limit, delimiter);

                    Map<Long, String> map = Arrays.stream(fileListing.items).collect(Collectors.toMap(fileInfo -> fileInfo.putTime, fileInfo -> fileInfo.key));
                    map.keySet().stream().sorted(Comparator.reverseOrder()).limit(maxFileNum).forEach(map::remove);
                    List<String> expireList = new ArrayList<>(map.values());
                    if (!expireList.isEmpty()) {
                        for (String fileName : expireList) {
                            bucketManager.delete("mufengobs", fileName);
                            log.info("7牛云备份删除成功：{}", fileName);
                            File perBakFile = new File(bakRootPath + File.separator + fileName);
                            if (perBakFile.exists()) {
                                perBakFile.delete();
                                log.info("本地备份删除成功：{}", fileName);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    log.error("备份删除失败：{}", e.getMessage());
                }
            }
        } catch (Exception e) {
            log.error("备份数据库失败：{}", e.getMessage());
        }
    }

    /**
     * 生成mysql備份文件
     */
    private static void getMysqlBak() {
        InputStream in = null;
        InputStreamReader xx = null;
        BufferedReader br = null;
        OutputStreamWriter writer = null;
        FileOutputStream fout = null;
        final String fileTmp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        // 7牛备份文件路径后缀
        fileName7qZip = "mysqlBackup" + "/" + fileTmp + ".zip";
        // 本地zip备份文件路径
        bakZipFilePath = bakRootPath + File.separator + fileTmp + ".zip";
        // 本地sql文件临时路径
        final String fileSqlPathTmp = bakRootPath + File.separator + fileTmp + ".sql";
        try {
            Runtime rt = Runtime.getRuntime();
            // 调用 调用mysql的安装目录的命令
            //Process child = rt.exec(" docker exec mysql sh -c 'mysqldump -h 111.230.32.175 -uroot -pmufeng2023  mogu_blog'");
            Process child = rt.exec(" mysqldump -h 111.230.32.175 -uroot -pmufeng2023  mogu_blog");
            // 设置导出编码为utf-8。这里必须是utf-8
            // 把进程执行中的控制台输出信息写入.sql文件，即生成了备份文件。注：如果不对控制台信息进行读出，则会导致进程堵塞无法运行
            in = child.getInputStream();// 控制台的输出信息作为输入流
            xx = new InputStreamReader(in, "utf-8");
            // 设置输出流编码为utf-8。这里必须是utf-8，否则从流中读入的是乱码
            String inStr;
            StringBuffer sb = new StringBuffer("");
            String outStr;
            // 组合控制台输出信息字符串
            br = new BufferedReader(xx);
            while ((inStr = br.readLine()) != null) {
                sb.append(inStr + "\r\n");
            }
            outStr = sb.toString();
            // 要用来做导入用的sql目标文件：
            File bakFile = new File(fileSqlPathTmp);
            bakFile.createNewFile();
            fout = new FileOutputStream(bakFile);
            writer = new OutputStreamWriter(fout, "utf-8");
            writer.write(outStr);
            writer.flush();
        } catch (Exception e) {
            e.printStackTrace();
            bakZipFilePath = null;
        } finally {
            try {
                in.close();
                xx.close();
                br.close();
                writer.close();
                fout.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        zipBakSql(fileSqlPathTmp);

    }

    /**
     * 压缩备份的sql文件
     *
     * @param fileSqlPathTmp
     */
    private static void zipBakSql(final String fileSqlPathTmp) {
        File fileSqlTmp = null;
        try {
            ZipFile zipFile = new ZipFile(bakZipFilePath);
            ArrayList filesToAdd = new ArrayList();
            fileSqlTmp = new File(fileSqlPathTmp);
            filesToAdd.add(fileSqlTmp);

            ZipParameters parameters = new ZipParameters();
            parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
            parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);

            //设置密码
            parameters.setEncryptFiles(true);
            parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_STANDARD);
            parameters.setPassword("mysqlbakpassword");
            zipFile.addFiles(filesToAdd, parameters);

        } catch (ZipException e) {
            e.printStackTrace();
            bakZipFilePath = null;
        }

        //删除临时导出的sql文件 ，只留备份
        try {
            fileSqlTmp.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

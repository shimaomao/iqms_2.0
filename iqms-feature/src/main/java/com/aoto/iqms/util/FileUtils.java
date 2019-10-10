package com.aoto.iqms.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FileUtils {
	// 将数据写入指定文件
	public static void outPutFiles(String json, String path, String fileName) {
		Writer writer;
		try {
			File file = new File(path);
			if (!file.exists()) {
				file.mkdirs();
			}
			writer = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");;
			writer.write(json);
			writer.flush();
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 将文件夹打包成zip
	public static void createZip(String resourcesPath, String targetPath, String name) throws Exception {
		File resourcesFile = new File(resourcesPath); // 源文件
		File targetFile = new File(targetPath); // 目的
		// 如果目的路径不存在，则新建
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}

		String targetName = name; // 目标压缩文件名
		FileOutputStream outputStream = new FileOutputStream(targetPath + "/" + targetName);
		ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(outputStream));
		createCompressedFile(out, resourcesFile, "");

		out.close();
	}

	public static void createCompressedFile(ZipOutputStream out, File file, String dir) throws Exception {
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			// 将文件夹添加到下一级打包目录
			if(!dir.equals("")){
				out.putNextEntry(new ZipEntry(dir + "/"));
			}

			dir = dir.length() == 0 ? "" : dir + "/";

			// 循环将文件夹中的文件打包
			for (int i = 0; i < files.length; i++) {
				createCompressedFile(out, files[i], dir + files[i].getName()); // 递归处理
			}
		} else {
			FileInputStream fis = new FileInputStream(file);

			out.putNextEntry(new ZipEntry(dir));
			// 进行写操作
			int j = 0;
			byte[] buffer = new byte[1024];
			while ((j = fis.read(buffer)) > 0) {
				out.write(buffer, 0, j);
			}
			// 关闭输入流
			fis.close();
		}
	}

	public static void deleteFile(File file) {
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				deleteFile(files[i]);
			}
		}
		file.delete();
	}
}

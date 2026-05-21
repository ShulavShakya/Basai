package basai.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

public class Helper {

    public static ArrayList<String> saveMultipleFiles(HttpServletRequest request,
                                                      String paramName,
                                                      String subFolder) {
        ArrayList<String> savedFileNames = new ArrayList<>();

        try {
            String uploadPath = getUploadPath(request, subFolder);
            if (uploadPath == null) {
                System.err.println("[Helper] Upload path is null for subFolder: " + subFolder);
                return savedFileNames;
            }

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("[Helper] Created upload dir: " + uploadPath + " → " + created);
            }

            int fileIndex = 0;

            for (Part part : request.getParts()) {

                if (!part.getName().equals(paramName) || part.getSize() == 0) continue;

                String originalName = getSubmittedFileName(part);
                if (originalName == null || originalName.isBlank()) continue;

                // Strip any OS path the browser may include
                originalName = new File(originalName).getName();

                // ── Unique name: timestamp + index + original name ────────
                String uniqueName = System.currentTimeMillis() + "_" + fileIndex + "_" + originalName;
                fileIndex++;

                File destFile = new File(uploadDir, uniqueName);

                try (InputStream  in  = part.getInputStream();
                     OutputStream out = new FileOutputStream(destFile)) {
                    byte[] buffer = new byte[8192];
                    int    bytes;
                    while ((bytes = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytes);
                    }
                }

                savedFileNames.add(uniqueName);
                System.out.println("[Helper] Saved: " + destFile.getAbsolutePath());
            }

        } catch (Exception e) {
            System.err.println("[Helper] Error saving files: " + e.getMessage());
            e.printStackTrace();
        }

        return savedFileNames;
    }

    public static String saveUploadedFile(HttpServletRequest request,
                                          String paramName,
                                          String subFolder) {
        ArrayList<String> files = saveMultipleFiles(request, paramName, subFolder);
        return files.isEmpty() ? null : files.get(0);
    }

    private static String getUploadPath(HttpServletRequest request, String subFolder) {
        ServletContext context = request.getServletContext();

        String path = context.getRealPath("/uploads/" + subFolder + "/");
        if (path != null) {
            return path;
        }

        String fallback = System.getProperty("user.home")
                + File.separator + "basai-uploads"
                + File.separator + subFolder;
        System.err.println("[Helper] getRealPath returned null — using fallback: " + fallback);
        return fallback;
    }

    private static String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;

        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                        .trim()
                        .replace("\"", "");
            }
        }
        return null;
    }

    public static void deleteFile(HttpServletRequest request,
                                  String fileName,
                                  String subFolder) {
        if (fileName == null || fileName.isBlank()) return;
        try {
            String uploadPath = getUploadPath(request, subFolder);
            if (uploadPath == null) return;

            File file = new File(uploadPath + File.separator + fileName);
            if (file.exists()) {
                boolean deleted = file.delete();
                System.out.println("[Helper] Deleted " + fileName + ": " + deleted);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
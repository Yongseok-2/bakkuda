package termpackage;

import java.io.File;

public class FileUploader {
    // 업로드된 파일 목록을 확인할 폴더 경로
    private static final String uploadPath = "C:\\Users\\Beomryeol\\git\\bagguda\\myapp\\src\\main\\webapp\\term_jsp\\upload";

    // 업로드된 파일 목록을 새로 고침하는 메소드
    public void refreshUploadFolder() {
        // 업로드 폴더 객체 생성
        File uploadDir = new File(uploadPath);

        // 폴더가 존재하는지 확인
        if (!uploadDir.exists()) {
            System.out.println("업로드 디렉토리가 존재하지 않습니다.");
            return;
        }

        // 폴더 내 파일 목록 가져오기
        File[] uploadedFiles = uploadDir.listFiles();

        // 파일이 존재하는 경우 파일 목록 출력
        if (uploadedFiles != null) {
            for (File file : uploadedFiles) {
                if (file.isFile()) {
                    System.out.println("업로드된 파일: " + file.getName());
                }
            }
        }
    }
}

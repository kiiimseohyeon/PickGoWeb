package dto;

import java.util.List;

public class PlaceDTO {
    private String name;
    private List<String> tags;
    private String image; // ✅ 이미지 파일명 필드 추가

    // 생성자
    public PlaceDTO(String name, List<String> tags) {
        this.name = name;
        this.tags = tags;
    }

    public PlaceDTO(String name, List<String> tags, String image) {
        this.name = name;
        this.tags = tags;
        this.image = image;
    }

    // Getter / Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    // ✅ image 필드 getter / setter 추가
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}

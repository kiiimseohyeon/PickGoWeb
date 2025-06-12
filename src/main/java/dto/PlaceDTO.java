package pick_go.dto;

import java.util.List;

public class PlaceDTO {
    private int id; // ✅ 아이디 추가
    private String name;
    private List<String> tags;
    private String image;
    private String tag;
    private String description;

    // 기본 생성자
    public PlaceDTO() {}

    // 생성자 오버로딩 (원하는 대로 더 추가 가능)
    public PlaceDTO(int id, String name, List<String> tags, String image, String description) {
        this.id = id;
        this.name = name;
        this.tags = tags;
        this.image = image;
        this.description = description;
    }

    public PlaceDTO(String name, List<String> tags, String image) {
        this.name = name;
        this.tags = tags;
        this.image = image;
    }

    // 🔽 Getter / Setter 전부 추가
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

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

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getTag() {
        return tag;
    }
    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}

//태그 정보 DTO
package dto;

public class Tag {
    private int id;
    private String name;  // 예: #가족여행

    // 생성자, Getter/Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}

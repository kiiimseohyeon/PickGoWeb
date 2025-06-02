package pick_go.dto;

public class PlaceDTO {
    private String name;

    public PlaceDTO() {}

    public PlaceDTO(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

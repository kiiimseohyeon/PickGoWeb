package pick_go.dto;

public class BannerDTO {
    private String imageUrl;
    private String bannerText;

    public BannerDTO(String imageUrl, String bannerText) {
        this.imageUrl = imageUrl;
        this.bannerText = bannerText;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getBannerText() {
        return bannerText;
    }
}


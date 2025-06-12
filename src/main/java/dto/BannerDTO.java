package pick_go.dao;

import java.sql.*;
import java.util.*;
import pick_go.dto.BannerDTO;

public class BannerDAO {
    public List<BannerDTO> getBanners() {
        List<BannerDTO> list = new ArrayList<>();
        String sql = "SELECT image_url, banner_text FROM banner ORDER BY sort_order";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new BannerDTO(
                    rs.getString("image_url"),
                    rs.getString("banner_text")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

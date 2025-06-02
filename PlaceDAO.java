package pick_go.dao;

import java.sql.*;
import java.util.*;

import pick_go.dto.PlaceDTO;

public class PlaceDAO {

    private static final String jdbcUrl = "jdbc:mysql://localhost:3306/ipp_pickgo?useSSL=false&serverTimezone=UTC";
    private static final String dbUser = "root";
    private static final String dbPass = "1234";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC 드라이버 로딩 실패", e);
        }
    }

    public List<PlaceDTO> findPlacesByTags(List<String> keywords) throws Exception {
        List<PlaceDTO> results = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass)) {

            String tagIdSql = "SELECT id FROM tag WHERE LOWER(name) IN (" +
                    String.join(",", Collections.nCopies(keywords.size(), "?")) + ")";
            PreparedStatement tagStmt = conn.prepareStatement(tagIdSql);
            for (int i = 0; i < keywords.size(); i++) {
                tagStmt.setString(i + 1, keywords.get(i));
            }

            ResultSet tagRs = tagStmt.executeQuery();
            List<Integer> tagIds = new ArrayList<>();
            while (tagRs.next()) {
                tagIds.add(tagRs.getInt("id"));
            }

            if (tagIds.size() != keywords.size()) {
                throw new Exception("❌ 입력한 태그 중 일부가 존재하지 않습니다.");
            }

            StringBuilder query = new StringBuilder();
            query.append("SELECT p.name ")
                 .append("FROM place p ")
                 .append("JOIN place_tag pt ON p.id = pt.place_id ")
                 .append("WHERE pt.tag_id IN (")
                 .append(String.join(",", Collections.nCopies(tagIds.size(), "?")))
                 .append(") ")
                 .append("GROUP BY p.id ")
                 .append("HAVING COUNT(DISTINCT pt.tag_id) = ?");

            PreparedStatement placeStmt = conn.prepareStatement(query.toString());
            int idx = 1;
            for (Integer tagId : tagIds) {
                placeStmt.setInt(idx++, tagId);
            }
            placeStmt.setInt(idx, tagIds.size());

            ResultSet placeRs = placeStmt.executeQuery();
            while (placeRs.next()) {
                String name = placeRs.getString("name");
                results.add(new PlaceDTO(name));
            }

            placeRs.close();
            placeStmt.close();
            tagRs.close();
            tagStmt.close();
        }

        return results;
    }
}

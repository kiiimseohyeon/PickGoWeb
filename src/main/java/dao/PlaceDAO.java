//place 테이블 조회 로직
package dao;

import java.sql.*;
import java.util.*;
import db.DBUtil;
import dto.Place;

public class PlaceDAO {
    private Connection conn;

    public PlaceDAO() {
        conn = DBUtil.getConnection();
    }

    // 지역 기반 장소 조회
    public List<Place> getPlacesByRegion(String region) {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM place WHERE region = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, region);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Place p = new Place();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setType(rs.getString("type"));
                p.setRegion(rs.getString("region"));
                p.setDescription(rs.getString("description"));
                places.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return places;
    }

    // 태그 기반 검색 (간단 예시)
    public List<Place> getPlacesByTag(String tag) {
        List<Place> places = new ArrayList<>();
        String sql = """
            SELECT p.* FROM place p
            JOIN place_tag pt ON p.id = pt.place_id
            JOIN tag t ON pt.tag_id = t.id
            WHERE t.name = ?
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tag);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Place p = new Place();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setType(rs.getString("type"));
                p.setRegion(rs.getString("region"));
                p.setDescription(rs.getString("description"));
                places.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return places;
    }
}

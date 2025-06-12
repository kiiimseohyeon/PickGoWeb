package pick_go.dao;

import java.sql.*;
import java.util.*;
import pick_go.dto.PlaceDTO;

public class PlaceDAO {

    // 카테고리 기반 조회 (id 포함)
    public List<PlaceDTO> findPlacesByCategory(String category) {
        List<PlaceDTO> list = new ArrayList<>();
        String sql = "SELECT id, name, image_url FROM place WHERE category = ?";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PlaceDTO dto = new PlaceDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setImage(rs.getString("image_url"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

   

    // 메인 배너 조회 (id 포함)
    public List<PlaceDTO> getMainBannerPlaces() {
        List<PlaceDTO> list = new ArrayList<>();
        String sql = "SELECT id, name, image_url FROM place WHERE id <= 15 ORDER BY id";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PlaceDTO dto = new PlaceDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setImage(rs.getString("image_url"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 장소 ID로 상세 정보 조회
    public PlaceDTO findById(int placeId) {
        PlaceDTO place = null;
        String sql = "SELECT id, name, image_url, description FROM place WHERE id = ?";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, placeId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                place = new PlaceDTO();
                place.setId(rs.getInt("id"));
                place.setName(rs.getString("name"));
                place.setImage(rs.getString("image_url"));
                place.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return place;
    }
    public List<PlaceDTO> findPlacesByExactTags(List<String> inputTags) {
        List<PlaceDTO> list = new ArrayList<>();
        if (inputTags == null || inputTags.isEmpty()) return list;

        String placeholders = String.join(",", Collections.nCopies(inputTags.size(), "?"));

        String sql = "SELECT p.id, p.name, p.image_url " +
                     "FROM place p " +
                     "JOIN place_tag pt ON p.id = pt.place_id " +
                     "JOIN tag t ON pt.tag_id = t.id " +
                     "WHERE LOWER(t.name) IN (" + placeholders + ") " +
                     "GROUP BY p.id " +
                     "HAVING COUNT(DISTINCT t.name) = ?";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < inputTags.size(); i++) {
                pstmt.setString(i + 1, inputTags.get(i).toLowerCase());
            }
            pstmt.setInt(inputTags.size() + 1, inputTags.size());

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PlaceDTO dto = new PlaceDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setImage(rs.getString("image_url"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // 새로운 메서드: 태그 이름 리스트 → 태그 ID 리스트
    public List<Integer> getTagIdsByNames(List<String> names) {
        List<Integer> ids = new ArrayList<>();
        if (names == null || names.isEmpty()) return ids;

        String placeholders = String.join(",", Collections.nCopies(names.size(), "?"));
        String sql = "SELECT id FROM tag WHERE LOWER(name) IN (" + placeholders + ")";

        try (Connection conn = DataBase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < names.size(); i++) {
                pstmt.setString(i + 1, names.get(i).toLowerCase());
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ids;
    }
 // 실제로 존재하는 태그 조합을 가진 장소만 반환 (입력 태그 중 가능한 것만)
    public List<PlaceDTO> findPlacesByTags(List<String> keywords) throws Exception {
        List<PlaceDTO> results = new ArrayList<>();

        try (Connection conn = DataBase.getConnection()) {

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
            query.append("SELECT p.id, p.name, p.image_url ")
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
                PlaceDTO dto = new PlaceDTO();
                dto.setId(placeRs.getInt("id"));
                dto.setName(placeRs.getString("name"));
                dto.setImage(placeRs.getString("image_url"));
                results.add(dto);
            }


            placeRs.close();
            placeStmt.close();
            tagRs.close();
            tagStmt.close();
        }

        return results;
    }



}


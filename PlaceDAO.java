package dao;

import java.util.*;
import dto.PlaceDTO;

public class PlaceDAO {

    private List<PlaceDTO> allPlaces;

    public PlaceDAO() {
        allPlaces = new ArrayList<>();

        // 장소 데이터 초기화
        allPlaces.add(new PlaceDTO("대전 계족산성", Arrays.asList("힐링", "30대", "40대"), "gyegok.jpg"));
        allPlaces.add(new PlaceDTO("대전 꿈돌이하우스", Arrays.asList("10대", "20대", "가족"), "ggumdori.jpg")); // ✅ 이미지 지정
        allPlaces.add(new PlaceDTO("대동하늘공원", Arrays.asList("힐링", "커플", "20대"), "daedongskypark.jpg"));
        allPlaces.add(new PlaceDTO("대청호자연수변공원", Arrays.asList("힐링", "가족", "커플"), "LakePark.jpg"));
        allPlaces.add(new PlaceDTO("대청호자연생태관", Arrays.asList("가족", "힐링", "30대"), "NaturalEcologyCenter.jpg"));
        // ... 다른 장소도 계속 추가 가능 ...
    }

    // 태그 기반 장소 검색
    public List<PlaceDTO> findPlacesByTags(List<String> inputTags) {
        List<PlaceDTO> result = new ArrayList<>();

        for (PlaceDTO place : allPlaces) {
            List<String> placeTagsLower = new ArrayList<>();
            for (String tag : place.getTags()) {
                placeTagsLower.add(tag.toLowerCase());
            }

            boolean allMatch = true;
            for (String input : inputTags) {
                if (!placeTagsLower.contains(input.toLowerCase())) {
                    allMatch = false;
                    break;
                }
            }

            if (allMatch) {
                result.add(place);
            }
        }

        return result;
    }
}

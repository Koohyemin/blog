package newBadge;

import java.text.SimpleDateFormat;
import java.util.*;

public class Badge {
	public Badge() {}
	
	public ArrayList<String> currentSevenDays() {
		ArrayList<String> currentSevenDays = new ArrayList<String>();
		
		// 최근 일주일 올라온 글에 new 뱃지 붙이기 -> 현재날짜 구하기, 현재날짜에서 일주일 사이 날짜 구하기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); // yyyy-MM-dd형식으로 날짜 받기
		
		Calendar todayCal = Calendar.getInstance();
		Calendar agoCal = Calendar.getInstance(); 
		
		Date today = todayCal.getTime(); // 현재 날짜
		String todayDate = format.format(todayCal.getTime());
		agoCal.add(agoCal.DATE,-8); // 8일 전 날짜 -> while문이 현재날짜와 같아지면 끝나기때문에 7일 전 날짜까지 나옴(오늘 포함, 일주일 전)
		String weekDate = format.format(agoCal.getTime());
		
		while(!todayDate.equals(weekDate)) { // 현재날짜 ~ 일주일 전 날짜
			agoCal.add(agoCal.DATE, 1);
			weekDate = format.format(agoCal.getTime());
			currentSevenDays.add(weekDate);
		}
		
		return currentSevenDays;
	}
}

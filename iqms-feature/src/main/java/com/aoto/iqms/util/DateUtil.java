
package com.aoto.iqms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	/**
	 * 将时间字符串转换为Date类型的日期
	 * @param dateString 时间字符串
	 * 标准格式为yyyy-MM-dd或者yyyy-MM-dd HH:mm:ss
	 * @return 传入其他长度的字符串将返回null,传入规定长度的
	 * 不合格字符串将抛出ParseException
	 */
	public static Date ToDate(String dateString){
		if(!validated(dateString)){
			return null;
		}
		SimpleDateFormat sdf=null;
		Date date = null;
		if(dateString.length()==8){
			sdf=new SimpleDateFormat("yyyyMMdd");
		}
		if(dateString.length()==10){
			sdf=new SimpleDateFormat("yyyy-MM-dd");
		}
		if(dateString.length()==19){
			sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}
		try {
			date = sdf.parse(dateString);
			/*//这
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, 1);
			date=cal.getTime();*/
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
		
	}

	private static boolean validated(String dateString) {
		if("".equals(dateString)||dateString==null){
			return false;
		}
		if(dateString.length()!=8&&dateString.length()!=10&&dateString.length()!=19)
		return false;
		return true;
	}
	/**
	 * 日期类型转换字符串
	 */
	public static String dateToString(Date date){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(date);
		return str;
	}
	
	/**
	 * 获取当前时间，返回yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static String getNow(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd HHmmss");
		String now=sdf.format(new Date());
		return now;
	}
	/**
	 * 获取当前月份
	 * @return
	 */
	public static String getCurrentPeriod(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
		String currentPeriod=sdf.format(new Date());
		return currentPeriod;
	}
	public static void main(String[] args) {
//		System.out.println(DateUtil.ToDate("2015-10-12"));
//		System.out.println(DateUtil.getNow());
//		System.out.println(DateUtil.getCurrentPeriod());
//		System.out.println(DateUtil.daysToBirthDay("371323198712155554"));
		/*System.out.println("371323198712155554".substring(10,14));
		System.out.println("19871215".substring(4,8));
		System.out.println(DateUtil.getTomorrow());*/
//		System.out.println(daysToBirthDay("19721229"));
		System.out.println(DateUtil.dateToWeek("2018-01-14"));
	}
	/**
	 * 判断是18位身份证以后才可以用
	 * @param idCard
	 * @return 当前时间距离本年生日的天数
	 */
	public static int daysToBirthDay(String birthday){
		Date birthDate=DateUtil.ToDate(birthday);
		String mouth="";
		if(birthday.length()==10){
			mouth = birthday.substring(5, 7);
		}else{
			mouth = birthday.substring(4, 6);
		}
		String now = DateUtil.getNow().substring(5,7);
		Calendar cal=Calendar.getInstance();
		cal.setTime(birthDate);
		Calendar cal2=Calendar.getInstance();
		if(now.equals("12")&&mouth.equals("01")){
			cal.set(Calendar.YEAR,cal2.get(Calendar.YEAR)+1);
		}else if(now.equals("01")&&mouth.equals("12")){
			cal.set(Calendar.YEAR,cal2.get(Calendar.YEAR)-1);
		}else{
			cal.set(Calendar.YEAR,cal2.get(Calendar.YEAR));
		}
		System.out.println(cal.getTime());
		System.out.println(cal2.getTime());
		long days=(cal2.getTimeInMillis()-cal.getTimeInMillis())/(24*60*60*1000);
		return Math.abs((int) days);
	}
	public static Date getTomorrow(){
		Calendar cal=Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		Date d=cal.getTime();
		return d;
	}
	/**
	 * 比较时间大小
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @throws ParseException 
	 */
	public static boolean compareDate(String beginTime,String endTime) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		Date begin = sdf.parse(beginTime);
		Date end = sdf.parse(endTime);
		return begin.before(end);
	}
	/**
	 * 计算星期几（1,2,3,4,5,6,7）
	 * @param dateTime
	 * @return
	 */
	public static int dateToWeek(String dateTime){
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
		int[] week = {7,1,2,3,4,5,6};
		Calendar cal = Calendar.getInstance();
		try {
			Date date = f.parse(dateTime);
			cal.setTime(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0){
			w = 0;
		}
        return week[w];
	}
}

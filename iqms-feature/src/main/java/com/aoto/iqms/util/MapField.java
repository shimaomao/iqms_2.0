package com.aoto.iqms.util;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;


/**
 * 通过类名和静态字段的值，获取静态字段的名称
 * @author daxian
 *
 */
public class MapField {
	/**
	 * 通过字段的值，获取类里面静态字段名称
	 * @param clazz  静态常量类，保存数据库列明和展示字段名
	 * @param value
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public static String getFieldName(Class clazz ,String value) throws IllegalArgumentException, IllegalAccessException{
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			int modifier = field.getModifiers();
			if (Modifier.isStatic(modifier) && field.get(clazz).equals(value)){
				return field.getName();
			}
		}
		return "";
	}
}

package com.sk.goodogs.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String filename = 
				AdminDao.class.getResource("/sql/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
// 벤용 ----------------------------------------

	
	
		
// ---------------------------------------

	
}

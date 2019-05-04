package com.cn.Util;

import org.hibernate.dialect.MySQLDialect;
import org.hibernate.dialect.function.SQLFunctionTemplate;
import org.hibernate.type.StandardBasicTypes;

public class MyLocalDialect extends MySQLDialect {

	public MyLocalDialect(){
		super();
        // 启动项目时可以看到打说明成功
        System.out.println("MyLocalDialect");     
        registerFunction("getChildLst", new SQLFunctionTemplate(StandardBasicTypes.STRING, "getChildLst(?1,?2)"));
	}
}

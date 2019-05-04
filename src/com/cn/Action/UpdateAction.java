package com.cn.Action;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Date;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Doctor;
import com.cn.POJO.Patient;
import com.cn.POJO.User;
import com.cn.Service.DoctorService;
import com.cn.Service.PatientService;
import com.cn.Service.UserService;
import com.cn.Util.MailUitl;
import com.cn.Util.RandomUUID;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Result;

public class UpdateAction extends ActionSupport {

	// 注入Service
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private PatientService patientService;
	public PatientService getPatientService() {
		return patientService;
	}
	public void setPatientService(PatientService patientService) {
		this.patientService = patientService;
	}
	
	private DoctorService doctorService;
	public DoctorService getDoctorService() {
		return doctorService;
	}
	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}
	
	//账户信息
	private String username;
	private String phone;
	private String email;
	private String hashcode;

	//共有信息
	private String name;
	private String sex;
	private Date birthday;
	
	//病人用户信息
	private String profession;
	private String address;
	private String zipcode;
	private String signature;
	private String cname;
	private String crelation;
	private String cphone;

	//医生用户信息
	private String department;
	private String title;
	private String desc;
	
	// 重置密码
	private String password;
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	//验证code
	private String code;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}

	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCrelation() {
		return crelation;
	}
	public void setCrelation(String crelation) {
		this.crelation = crelation;
	}
	public String getCphone() {
		return cphone;
	}
	public void setCphone(String cphone) {
		this.cphone = cphone;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHashcode() {
		return hashcode;
	}
	public void setHashcode(String hashcode) {
		this.hashcode = hashcode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String update() {
		System.out.println("进入UpdateAction");

		User user = (User) ActionContext.getContext().getSession().get("loginUser");
		user.setPhone(phone);
		user.setEmail(email);

		Patient patient = user.getPatient();
		patient.setName(name);
		patient.setSex(Integer.parseInt(sex));
//		if ("1".equals(sex)) {
//			patient.setSex(1);
//		} else {
//			patient.setSex(0);
//		}
		patient.setBirthday(birthday);
		patient.setProfession(profession);
		patient.setAddress(address);
		patient.setZipcode(zipcode);
		patient.setSignature(signature);

		patient.setCname(cname);
		patient.setCrelation(crelation);
		patient.setCphone(cphone);

		userService.update(user);
		patientService.update(patient);
		return "SUCCESS";
	}
	
	public String updateDoctor(){
		System.out.println("更新医生信息");
		
		User user = (User) ActionContext.getContext().getSession().get("loginUser");
		user.setPhone(phone);
		user.setEmail(email);
		
		System.out.println(name + "," + sex + "," + birthday + "," + department + "," + title + "," + desc);
		
		Doctor doctor = user.getDoctor();
		System.out.println(doctor);
		doctor.setName(name);
		doctor.setSex(Integer.parseInt(sex));
		doctor.setBirthday(birthday);
		doctor.setDepartment(Integer.parseInt(department));
		doctor.setTitle(Integer.parseInt(title));
		doctor.setDescription(desc);
		
		userService.update(user);
		doctorService.update(doctor);
		return "SUCCESS";
	}

	public String resetPwd() {
		System.out.println("进入修改密码Action，并且获取密码为：" + password);

		User user = (User) ActionContext.getContext().getSession().get("loginUser");
		user.setPassword(password);
		userService.update(user);
		return "SUCCESS";
	}

	//通过邮箱找回密码：1.向邮箱发送重置密码链接
	public String resetPwdByEmail() throws IOException {
		System.out.println("邮箱更改密码Action");
		System.out.println("email:" + email);

		int indexOfAt = email.indexOf("@");
		int indexOfDot = email.indexOf(".");
		String mailStation = email.substring(indexOfAt + 1, indexOfDot);
		// System.out.println("===" + indexOfAt+ "-" + indexOfDot + "-" +
		// email.substring(indexOfAt+1, indexOfDot));

		// 添加重置验证code
		String code = RandomUUID.getRandomUUID();
		User user = userService.findByWhat("email", email);
		user.setCode(code);
		userService.update(user);

		System.out.println("code添加完成");
		// 向目标邮箱发送邮件
		MailUitl.sendMail(email, code);

		System.out.println("邮件发送成功");

		if ("QQ".equals(mailStation.toUpperCase())) {
			return "QQSUCCESS";
		}else if ("SINA".equals(mailStation.toUpperCase())) {
			return "SINASUCCESS";
		}else if ("189".equals(mailStation)) {
			return "189SUCCESS";
		}else if ("163".equals(mailStation) || "126".equals(mailStation) || "YEAH".equals(mailStation.toUpperCase())) {
			return "163SUCCESS";
		}
		return "SUCCESS";
	}
	
	//通过邮箱找回密码：2.通过code定位用户，修改密码并使code失效
	public String resetPwdByCode(){
		User user = userService.findByWhat("code", code);
		user.setPassword(password);
		user.setCode("");
		userService.update(user);
		return "SUCCESS";
	}
	
	//注册医生账户
	public String addDoctorAccount(){
		System.out.println("获取到的参数有：");
		System.out.println(username + "," + phone + "," + email + "," + department + "," + title);
		User user = new User();
		String uuid = RandomUUID.getRandomUUID();
		user.setRole(1);
		user.setUuid(uuid);
		user.setUsername(username);
		user.setPassword(username);
		user.setPhone(phone);
		user.setEmail(email);
		userService.register(user);
		
		Doctor doctor = new Doctor();
		doctor.setDid(user.getUid());
		doctor.setDepartment(Integer.parseInt(department));
		doctor.setTitle(Integer.parseInt(title));
		doctorService.save(doctor);
		
		//多表连接
		user.setDoctor(doctor);
		doctor.setUser(user);
		userService.update(user);
		doctorService.update(doctor);
		
		return "SUCCESS";
	}
	
}

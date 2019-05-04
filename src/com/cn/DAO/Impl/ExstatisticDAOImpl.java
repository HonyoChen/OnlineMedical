package com.cn.DAO.Impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.ExstatisticDAO;
import com.cn.POJO.Exrecord;
import com.cn.POJO.Exstatistic;

import net.sf.json.JSONObject;

public class ExstatisticDAOImpl extends HibernateDaoSupport implements ExstatisticDAO {

	@Override
	public void save(Exstatistic exstatistic) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().save(exstatistic);
	}

	@Override
	public JSONObject statictisResult(Integer pid) {
		JSONObject json = new JSONObject();//返回结果
		JSONObject json_onset = new JSONObject();//用于存放onset内容
		JSONObject json_factor = new JSONObject();//用于存放factor内容
		JSONObject json_state = new JSONObject();//用于存放state内容
		JSONObject json_state_0_status = new JSONObject();//用于存放全面性发作持续状态内容
		JSONObject json_state_1_status = new JSONObject();//用于存放部分性发作持续状态内容
		
		//存放发作先兆统计结果
		int count_onset_0 = 0;
		int count_onset_1 = 0;
		int count_onset_2 = 0;
		int count_onset_3 = 0;
		
		//存放诱发因素统计结果
		int count_factor_0 = 0;
		int count_factor_1 = 0;
		int count_factor_2 = 0;
		int count_factor_3 = 0;
		int count_factor_4 = 0;
		int count_factor_5 = 0;
		int count_factor_6 = 0;
		
		//存放发作状态大类统计结果
		int count_state_0 = 0;
		int count_state_1 = 0;
		
		//存放发作状态小类统计结果
		int count_state_0_status_0 = 0;
		int count_state_0_status_1 = 0;
		int count_state_0_status_2 = 0;
		int count_state_0_status_3 = 0;
		int count_state_0_status_4 = 0;
		int count_state_1_status_0 = 0;
		int count_state_1_status_1 = 0;
		int count_state_1_status_2 = 0;
		int count_state_1_status_3 = 0;
		
		String hql = "FROM Exstatistic WHERE eid IN (SELECT eid FROM Exrecord WHERE pid = ?)";
		List<Exstatistic> result = (List<Exstatistic>) this.getHibernateTemplate().find(hql, pid);
		if (result != null && result.size() > 0) {
			System.out.println("返回结果长度：" + result.size());
			for (Exstatistic exstatistic : result) {
				//统计onset内容
				switch (exstatistic.getOnset()) {
					case 0:
						count_onset_0++;
						break;
					case 1:
						count_onset_1++;
						break;
					case 2:
						count_onset_2++;
						break;
					case 3:
						count_onset_3++;
						break;
					default:
						break;
				}
				
				//统计factor内容
				switch (exstatistic.getFactor()) {
					case 0:
						count_factor_0++;
						break;
					case 1:
						count_factor_1++;
						break;
					case 2:
						count_factor_2++;
						break;
					case 3:
						count_factor_3++;
						break;
					case 4:
						count_factor_4++;
						break;
					case 5:
						count_factor_5++;
						break;
					case 6:
						count_factor_6++;
						break;
					default:
						break;
				}
				
				//统计state和status内容
				switch (exstatistic.getState()) {
					case 0:
						count_state_0++;
						switch (exstatistic.getStatus()) {
						case 0:
							count_state_0_status_0++;
							break;
						case 1:
							count_state_0_status_1++;
							break;
						case 2:
							count_state_0_status_2++;
							break;
						case 3:
							count_state_0_status_3++;
							break;
						case 4:
							count_state_0_status_4++;
							break;
						default:
							break;
						}
						break;
					case 1:
						count_state_1++;
						switch (exstatistic.getStatus()) {
						case 0:
							count_state_1_status_0++;
							break;
						case 1:
							count_state_1_status_1++;
							break;
						case 2:
							count_state_1_status_2++;
							break;
						case 3:
							count_state_1_status_3++;
							break;
						default:
							break;
						}
						break;
					default:
						break;
				}
			}
		}
		
		//放置onset统计结果
		json_onset.put("onset_0", count_onset_0);
		json_onset.put("onset_1", count_onset_1);
		json_onset.put("onset_2", count_onset_2);
		json_onset.put("onset_3", count_onset_3);
		
		//放置factor统计结果
		json_factor.put("factor_0", count_factor_0);
		json_factor.put("factor_1", count_factor_1);
		json_factor.put("factor_2", count_factor_2);
		json_factor.put("factor_3", count_factor_3);
		json_factor.put("factor_4", count_factor_4);
		json_factor.put("factor_5", count_factor_5);
		json_factor.put("factor_6", count_factor_6);
		
		//放置state_0统计结果
		json_state_0_status.put("state_0_status_0", count_state_0_status_0);
		json_state_0_status.put("state_0_status_1", count_state_0_status_1);
		json_state_0_status.put("state_0_status_2", count_state_0_status_2);
		json_state_0_status.put("state_0_status_3", count_state_0_status_3);
		json_state_0_status.put("state_0_status_4", count_state_0_status_4);
		
		//放置state_1统计结果
		json_state_1_status.put("state_1_status_0", count_state_1_status_0);
		json_state_1_status.put("state_1_status_1", count_state_1_status_1);
		json_state_1_status.put("state_1_status_2", count_state_1_status_2);
		json_state_1_status.put("state_1_status_3", count_state_1_status_3);
		
		//放置state统计结果
		json_state.put("state_0", json_state_0_status);
		json_state.put("state_1", json_state_1_status);
		json_state.put("count_0", count_state_0);
		json_state.put("count_1", count_state_1);
		
		//存放返回结果
		json.put("onset", json_onset);
		json.put("factor", json_factor);
		json.put("state", json_state);
		System.out.println(json.toString());
		return json;
	}
}

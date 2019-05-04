package com.cn.Util;

//用于模型训练过程中间将字符内容转换为JSON对象
public class Train {

	private int iter;
	private float loss;
	private float accu;
	
	public int getIter() {
		return iter;
	}
	public void setIter(int iter) {
		this.iter = iter;
	}
	public float getLoss() {
		return loss;
	}
	public void setLoss(float loss) {
		this.loss = loss;
	}
	public float getAccu() {
		return accu;
	}
	public void setAccu(float accu) {
		this.accu = accu;
	}
}

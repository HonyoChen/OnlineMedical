package com.cn.Util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.tensorflow.Graph;
import org.tensorflow.Session;
import org.tensorflow.Tensor;

public class TensorPredict {

	private String MODEL_PATH = System.getProperty("catalina.home") + File.separator + "webapps" + File.separator
			+ "OnlineMedical" + File.separator + "train" + File.separator + "model" + File.separator;

	// 采用默认模型进行预测
	public int tensorPredict(float[] ecgs) throws FileNotFoundException, IOException {
		try (Graph graph = new Graph()) {
			// 导入图
			byte[] graphBytes = IOUtils.toByteArray(new FileInputStream(MODEL_PATH + "model.pb"));
			graph.importGraphDef(graphBytes);

			float[][] arr = new float[178][1];
			for (int index = 0; index < arr.length; index++) {
				arr[index][0] = ecgs[index];
			}
			float[][][] data = new float[1][178][1];
			data[0] = arr;

			long[] shape = { 1, 178, 1 };
			// 根据图建立Session
			try (Session session = new Session(graph)) {
				List<Tensor<?>> out = session.runner().feed("x", Tensor.create(data)).fetch("output").run();

				float[][] answer = new float[1][2];
				out.get(0).copyTo(answer);
				if (answer[0][0] < answer[0][1]) {
					return 0;
				} else {
					return 1;
				}
			}

		}
	}

	// 采用指定模型进行预测
	public int tensorPredict(String modelName, float[] ecgs) throws FileNotFoundException, IOException {
		try (Graph graph = new Graph()) {
			// 导入图
			byte[] graphBytes = IOUtils.toByteArray(new FileInputStream(MODEL_PATH + modelName));
			graph.importGraphDef(graphBytes);

			float[][] arr = new float[178][1];
			for (int index = 0; index < arr.length; index++) {
				arr[index][0] = ecgs[index];
			}
			float[][][] data = new float[1][178][1];
			data[0] = arr;

			long[] shape = { 1, 178, 1 };
			// 根据图建立Session
			try (Session session = new Session(graph)) {
				List<Tensor<?>> out = session.runner().feed("x", Tensor.create(data)).fetch("output").run();

				float[][] answer = new float[1][2];
				out.get(0).copyTo(answer);
				if (answer[0][0] < answer[0][1]) {
					return 0;
				} else {
					return 1;
				}
			}
		}
	}
}

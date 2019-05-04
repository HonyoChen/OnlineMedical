# -*- coding: utf-8 -*-
"""
Created on Sun Jul 29 14:33:26 2018

@author: Honyo
"""
import tensorflow as tf
import numpy as np
import input_data
import sys
import csv
rpath = sys.argv[0]
rpath = rpath[0: len(rpath)-14]
#print(rpath)


# learning_rate = 0.0001
# training_iters = 50
# batch_size = 200

# 解析参数
epsilon = sys.argv[1]
epsilon = epsilon.split('=')[1]
training_iters = sys.argv[2]
training_iters = training_iters.split('=')[1]
learning_rate = sys.argv[3]
learning_rate = learning_rate.split('=')[1]
batch_size = sys.argv[4]
batch_size = batch_size.split('=')[1]

# 定义超参
epsilon = float(epsilon)
training_iters = int(training_iters)
learning_rate = float(learning_rate)
batch_size = int(batch_size)
display_step = 1

#重置图
tf.reset_default_graph()

n_input =1 #序列中每一个时刻的输入维数，本实验只有一个值，为脑电波数值
n_steps = 178 #序列个数
n_hidden = 128 # 隐藏层个数
n_classes = 2 # 二分类问题

# 定义占位符
x = tf.placeholder('float', [None, n_steps, n_input], name='x')
y = tf.placeholder('float', [None, n_classes])

x1 = tf.unstack(x, n_steps, axis=1)
# 基本的LSTM Cell
lstm_cell = tf.contrib.rnn.BasicLSTMCell(n_hidden, forget_bias=1.0)
outputs, states = tf.contrib.rnn.static_rnn(lstm_cell, x1, dtype=tf.float32)

#pred = tf.contrib.layers.fully_connected(outputs[-1], n_classes, activation_fn=tf.tanh)
pred = tf.layers.dense(outputs[-1], n_classes, activation=tf.tanh, name='pred')
prediction_labels = tf.subtract(pred, 0, name='output')

# 定义损失函数及优化方法
# cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=pred, labels=y)) + np.random.laplace(0, 2./batch_size/epsilon, 1)[0]
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=pred, labels=y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(cost)

# 评估模型
correct_pred = tf.equal(tf.argmax(pred, 1), tf.argmax(y, 1))
accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

#保存模型
#saver = tf.train.Saver()
#builder = tf.saved_model.builder.SavedModelBuilder('logssss')

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    
    out_csv_path = rpath + 'result/' + str(epsilon) + '-' + str(training_iters) + '-' + str(learning_rate) + '-' + str(batch_size) + '-result.csv'
    csv_out = open(out_csv_path, 'w', newline='');
    csv_write = csv.writer(csv_out,dialect='excel')
    
    step = 0
    
    while step < training_iters:
        batch_x, batch_y = input_data.nextBatchTrain(batch_size)
        batch_x = batch_x.values
        batch_y = batch_y.tolist()
#        if(step % 30 == 0):
#            print(batch_y)
        batch_x = np.reshape(batch_x, (batch_size,n_steps,n_input))
#        batch_y = np.reshape(batch_y, (-1, n_classes))
        
#        执行优化操作
        sess.run(optimizer, feed_dict={x:batch_x, y:batch_y})
        if(step % display_step == 0):
            #计算批次数据的准确率
            acc = sess.run(accuracy, feed_dict={x:batch_x, y:batch_y})
            #计算批次数据的损失
            loss = sess.run(cost, feed_dict={x:batch_x, y:batch_y})
            print('Iter=' + str(step+1) + ',Minibatch Loss=' + '{:.6f}'.format(loss) + ',Training Accuracy=' + '{:.6f}'.format(acc))
            csv_write.writerow([str(step+1), '{:.6f}'.format(loss), '{:.6f}'.format(acc)])
        step += 1
    print('Finished!')
#    saver.save(sess, "log/model.cpkt")
#    builder.add_meta_graph_and_variables(sess, ['custom'])
    
    #显示图中的节点
    # print(n.name for n in sess.graph.as_graph_def().node)
    output_graph_def = tf.graph_util.convert_variables_to_constants(sess, sess.graph_def, output_node_names=['output'])
    model_name = rpath + 'model/' + str(epsilon) + '-' + str(training_iters) + '-' + str(learning_rate) + '-' + str(batch_size) + '-model.pb'
    with tf.gfile.FastGFile(model_name, mode='wb') as f:
        f.write(output_graph_def.SerializeToString())
    
#    batch_testX, batch_testY = input_data.nextBatchTest(batch_size)
#    batch_testX = batch_testX.values
#    batch_testY = batch_testY.tolist()
#    batch_testX = np.reshape(batch_testX, (-1,n_steps,n_input))
#    print('Testing Accuracy:', sess.run(accuracy, feed_dict={x:batch_testX, y:batch_testY}))
#    print('Labels:', batch_testY)
#    print('pred prop:', sess.run(pred, feed_dict={x:batch_testX}))
#    print('Prediction:', sess.run(prediction_labels, feed_dict={x:batch_testX}))
#    
#    X = [135,190,229,223,192,125,55,-9,-33,-38,-10,35,64,113,152,164,127,50,-47,-121,-138,-125,-101,-50,11,39,24,48,64,46,13,-19,-61,-96,-130,-132,-116,-115,-71,-14,25,19,6,9,21,13,-37,-58,-33,5,47,80,101,88,73,69,41,-13,-31,-61,-80,-77,-66,-43,5,87,129,121,88,12,-76,-150,-207,-186,-165,-148,-103,-33,40,94,75,8,-81,-155,-227,-262,-233,-218,-187,-126,-65,-12,27,61,49,9,-46,-124,-210,-281,-265,-181,-89,-4,53,53,38,43,31,34,9,-7,-34,-70,-84,-101,-70,-11,42,62,66,74,64,59,56,36,-11,-30,-43,-23,8,42,77,103,135,121,79,59,43,54,90,111,107,64,32,18,-25,-69,-65,-44,-33,-57,-88,-114,-130,-114,-83,-53,-79,-72,-85,-109,-98,-72,-65,-63,-11,10,8,-17,-15,-31,-77,-103,-127,-116,-83,-51]
#    X = np.array(X)
#    X = np.reshape(X, (-1,n_steps,n_input))
#    print("Test", sess.run(pred, feed_dict={x:X}))
#builder.save()
#with tf.Session() as sess2:
#    sess2.run(tf.global_variables_initializer())
#    saver.restore(sess2, "log/model.cpkt")
#    
#    batch_testX, batch_testY = input_data.nextBatchTest(10)
#    batch_testX = batch_testX.values
#    batch_testY = batch_testY.tolist()
#    batch_testX = np.reshape(batch_testX, (-1,n_steps,n_input))
#    print('Testing Accuracy:', sess2.run(accuracy, feed_dict={x:batch_testX, y:batch_testY}))
#    print('Pred', sess2.run(pred, feed_dict={x:batch_testX}))
#    print('y', batch_testY)
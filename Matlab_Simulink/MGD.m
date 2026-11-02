function X = MGD(q)

global a1 a2

q1 = q(1);
q2 = q(2);

x = a1 * cos(q1) + a2 * cos(q1+q2);
y = a1 * sin(q1) + a2 * sin(q1+q2);

X = [x; y];

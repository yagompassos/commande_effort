function q = MGI(X)

global a1 a2

x = X(1);
y = X(2);

C2 = (x^2+y^2-a1^2-a2^2)/(2*a1*a2);
S2 = -sqrt(1-C2^2);

q2 = atan2(S2, C2);

z1 = a1+a2*C2;
z2 = a2*S2;

S1 = (z1*y-z2*x)/(z1^2+z2^2);

C1 = (z1*x+z2*y)/(z1^2+z2^2);

q1 = atan2(S1, C1);

q = [q1; q2];




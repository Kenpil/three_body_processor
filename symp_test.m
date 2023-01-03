clear all:
clc;

dt = 0.0001;
n = 150000;

qa = zeros(n + 1, 2);
% ~~ Pythagorean~~
ma = 3;
qa(1, :) = [1, 3];
pa = [0, 0];
% ~~ "8" trajectory ~~
% ma = 1;
% qa(1, :) = [0.97000436, -0.24308753];
% pa = [-0.5 * 0.93240737, -0.5 * 0.86473146];

qb = zeros(n + 1, 2);
% ~~ Pythagorean~~
mb = 4;
qb(1, :) = [-2, -1];
pb = [0, 0];
% "8" trajectory
% mb = 1;
% qb(1, :) = [-0.97000436, 0.24308753];
% pb = [-0.5 * 0.93240737,  -0.5 * 0.86473146];

qc = zeros(n + 1, 2);
% ~~ Pythagorean~~
mc = 5;
qc(1, :) = [1, -1];
pc = [0, 0];
% "8" trajectory
% mc = 1;
% qc(1, :) = [0, 0];
% pc = [0.93240737, 0.86473146];

for i = 1:n % i th step
    % r
    rab = sqrt((qa(i,1)-qb(i,1))^2 + (qa(i,2)-qb(i,2))^2);
    rbc = sqrt((qb(i,1)-qc(i,1))^2 + (qb(i,2)-qc(i,2))^2);
    rca = sqrt((qc(i,1)-qa(i,1))^2 + (qc(i,2)-qa(i,2))^2);
    % a star
    Fa = -mb * (qa(i,:)-qb(i,:)) / (rab^3) - mc * (qa(i,:)-qc(i,:)) / (rca^3);
    pa = pa + Fa * dt;
    qa(i+1,:) = qa(i,:) + pa * dt;
    % b star
    Fb = -ma * (qb(i,:)-qa(i,:)) / (rab^3) - mc * (qb(i,:)-qc(i,:)) / (rbc^3);
    pb = pb + Fb * dt;
    qb(i+1,:) = qb(i,:) + pb * dt;
    % c star
    Fc = -ma * (qc(i,:)-qa(i,:)) / (rca^3) - mb * (qc(i,:)-qb(i,:)) / (rbc^3);
    pc = pc + Fc * dt;
    qc(i+1,:) = qc(i,:) + pc * dt;
end

sta = 1;
fin = n;
figStep = 100;
figure;
plot(qa(sta:figStep:fin, 1), qa(sta:figStep:fin, 2));
hold on;
plot(qb(sta:figStep:fin, 1), qb(sta:figStep:fin, 2));
hold on;
plot(qc(sta:figStep:fin, 1), qc(sta:figStep:fin, 2));
hold off;
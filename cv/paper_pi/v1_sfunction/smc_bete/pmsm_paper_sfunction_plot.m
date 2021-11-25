close all;

figure(1);

%plot speed of motor

plot(wm,'b','linewidth',2);
%横坐标坐标刻度设置
%set(gca,'xtick',0:0.1:0.4)
%很总坐标坐标名称
xlabel('time(s)','fontname','Times');ylabel('$n$(r/min)','Interpreter','latex');

title('')
%图例字体，字号
x1d=legend('$\omega_m$');
set(x1d,'Interpreter','latex','FontSize',28,'box','off','Location','northeast')
%坐标轴刻度字体，字号
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');
delete(get(gca,'title'));
grid on



figure(2);

plot(ia,'r','linewidth',2);
hold on
plot(ib,'--b','linewidth',2);
hold on
plot(ic,'-.g','linewidth',2);
%set(gca,'xtick',0:0.1:0.4);
xlabel('time(s)','Interpreter','latex');ylabel('$i/A$','Interpreter','latex');

x1d=legend('$i_a$','$i_b$','$i_c$');
set(x1d,'Interpreter','latex','FontSize',28,'box','off','Location','northeast')
title('')
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');
delete(get(gca,'title'));
grid on

figure(3);
grid on
plot(Te,'r','linewidth',2);
%set(gca,'xtick',0:0.1:0.4);
xlabel('time(s)','FontSize',20,'Interpreter','latex');ylabel('$i/A$','FontSize',20,'Interpreter','latex');

x1d=legend('$Te$');
set(x1d,'Interpreter','latex','FontSize',28,'box','off','Location','northeast')
title('')
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');
delete(get(gca,'title'));
grid on
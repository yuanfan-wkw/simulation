close all;

figure(1);
plot(out.x1,'-.r','linewidth',2);
xlabel('time(s)','FontSize',20);ylabel('postion tracking (rad)','FontSize',20);
title('')
hold on
plot(out.x1d,'b','linewidth',2);
x1d=legend('$x_1$','$x_{1d}$');
set(x1d,'Interpreter','latex','FontSize',28,'box','off','Location','north')
delete(get(gca,'title'));




figure(2);
plot(out.u,'r','linewidth',2);
xlabel('time(s)','FontSize',20);ylabel('Control input (N)','FontSize',20);
title('')
delete(get(gca,'title'));
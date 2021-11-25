close all;

figure(1);
plot(out.x1,'-.r','linewidth',2);
xlabel('time(s)','FontSize',20,'FontName','Times New Roman');ylabel('postion tracking','FontSize',20,'FontName','Times New Roman');
title('')
hold on
plot(out.x1d,'b','linewidth',2);
x1d=legend('$x_1$','$x_{1d}$');
set(x1d,'Interpreter','latex','FontSize',28,'box','off','Location','north')
delete(get(gca,'title'));




figure(2);
plot(out.u,'r','linewidth',2);
xlabel('time(s)','FontSize',20,'FontName','Times New Roman');ylabel('Control input ','FontSize',20,'FontName','Times New Roman');
title('')
delete(get(gca,'title'));
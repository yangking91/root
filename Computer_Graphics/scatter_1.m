t=0:pi/10:2*pi; y=sin(t)
subplot(3,2,1); scatter(t,y)
subplot(3,2,2); scatter(t,y,'v')
subplot(3,2,3); scatter(t,y,(abs(y)+2).^4,'filled')
subplot(3,2,4); scatter(t,y,30,[0:2: 40],'v','filled')
subplot(3,2,5); scatter(t,y,(t+1).^3,y,'filled')
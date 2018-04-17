%% File
FILE = load('1stExperiments.mat');
LENGTH = 20;
%% PI-ST
% According to this path integration mode, AntBot computes both its travel
% distance and its heading using only the stride integration. 
% Mean distance per straight forward walking stride: 8.2cm
% Mean rotation per turning stride: 10.9°
% Raw Data :
X_INIT = FILE.PI_ST.X(:,1);
Y_INIT = FILE.PI_ST.Y(:,1);
X_TRAJ = FILE.PI_ST.X(:,2:6);
Y_TRAJ = FILE.PI_ST.Y(:,2:6);
X_HOME = FILE.PI_ST.X(:,7:end);
Y_HOME = FILE.PI_ST.Y(:,7:end);
% Variables for position corrected according to position init. :
X_TRAJ_CORR_POS = X_TRAJ;
Y_TRAJ_CORR_POS = Y_TRAJ;
X_HOME_CORR_POS = X_HOME;
Y_HOME_CORR_POS = Y_HOME;
figure()
for i = 1:LENGTH
    subplot(4,5,i)
    hold on;
    plot(0,0,'black*','linewidth',1.2);
        for j = 1:5
            X_TRAJ_CORR_POS(i,j) = X_TRAJ(i,j) - X_INIT(i,1);
            Y_TRAJ_CORR_POS(i,j) = Y_TRAJ(i,j) - Y_INIT(i,1);
        end
    plot(X_TRAJ_CORR_POS(i,:),Y_TRAJ_CORR_POS(i,:),'blue','linewidth',1.3);
        for j = 6:13
            X_HOME_CORR_POS(i,j-5) = X_HOME(i,j-5) - X_INIT(i,1);
            Y_HOME_CORR_POS(i,j-5) = Y_HOME(i,j-5) - Y_INIT(i,1);
        end
    plot(X_HOME_CORR_POS(i,:),Y_HOME_CORR_POS(i,:),'red','linewidth',1.3);
    plot([0 X_TRAJ_CORR_POS(i,1)],[0 Y_TRAJ_CORR_POS(i,1)],'blue','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(i,end) X_HOME_CORR_POS(i,1)],[Y_TRAJ_CORR_POS(i,end) Y_HOME_CORR_POS(i,1)],'red','linewidth',1.3);
    axis([-0.25 2.25 -1.75 1]);
    box on;
    axis equal;
    hold off;
    title(strcat('Test_{',num2str(i),'}'));
end
figure()
    hold on;
    plot(0,0,'black+','linewidth',1.2,'markersize',10);
    plot([0*ones(LENGTH,1) X_TRAJ_CORR_POS(:,1)]',[0*ones(LENGTH,1) Y_TRAJ_CORR_POS(:,1)]','blue','linewidth',1.3);
    plot(X_TRAJ_CORR_POS(:,:)',Y_TRAJ_CORR_POS(:,:)','blue','linewidth',1.3);
    plot(X_HOME_CORR_POS(:,:)',Y_HOME_CORR_POS(:,:)','red','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(:,end) X_HOME_CORR_POS(:,1)]',[Y_TRAJ_CORR_POS(:,end) Y_HOME_CORR_POS(:,1)]','red','linewidth',1.3);
            [A,c] = MinVolEllipse([X_HOME_CORR_POS(:,end) Y_HOME_CORR_POS(:,end)]',.001);
            Ellipse_plot(A,c);
            plot(c(1),c(2),'+','color',[0.2 0.5 0.4],'linewidth',1.4,'markersize',10);
    axis([-0.25 2.25 -1.75 1]); axis equal;
    hold off;
    box on;
    grid on;
    grid minor;
FullLengthPI_ST = zeros(LENGTH,1);
X1 = [X_INIT X_TRAJ X_HOME];
Y1 = [Y_INIT Y_TRAJ Y_HOME];
for i = 1:LENGTH
    for j = 1:13
        FullLengthPI_ST(i) = FullLengthPI_ST(i) + sqrt((X1(i,j+1) - X1(i,j))^2 + (Y1(i,j+1) - Y1(i,j))^2);
    end
end
HomingDistPI_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingDistPI_ST(i) = sqrt((X_TRAJ(i,end) - X_INIT(i,1))^2 + (Y_TRAJ(i,end) - Y_INIT(i,1))^2);
end
HomingErrorPI_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingErrorPI_ST(i) = sqrt((X_HOME(i,end) - X_INIT(i,1))^2 + (Y_HOME(i,end) - Y_INIT(i,1))^2);
end
HomingPctPI_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingPctPI_ST(i) = HomingErrorPI_ST(i) * 100 / FullLengthPI_ST(i);
end
%% PI-OF-ST
% According to this path integration mode, AntBot computes its travel
% distance based the ventral optic flow, and its heading using only the 
% stride integration. 
% Mean distance per straight forward walking stride: 8.2cm
% Mean rotation per turning stride: 10.9°
% Raw Data :
X_INIT = FILE.PI_OF_ST.X(:,1);
Y_INIT = FILE.PI_OF_ST.Y(:,1);
X_TRAJ = FILE.PI_OF_ST.X(:,2:6);
Y_TRAJ = FILE.PI_OF_ST.Y(:,2:6);
X_HOME = FILE.PI_OF_ST.X(:,7:end);
Y_HOME = FILE.PI_OF_ST.Y(:,7:end);
% Variables for position corrected according to position init. :
X_TRAJ_CORR_POS = X_TRAJ;
Y_TRAJ_CORR_POS = Y_TRAJ;
X_HOME_CORR_POS = X_HOME;
Y_HOME_CORR_POS = Y_HOME;
figure()
for i = 1:LENGTH
    subplot(4,5,i)
    hold on;
    plot(0,0,'black*','linewidth',1.2);
        for j = 1:5
            X_TRAJ_CORR_POS(i,j) = X_TRAJ(i,j) - X_INIT(i,1);
            Y_TRAJ_CORR_POS(i,j) = Y_TRAJ(i,j) - Y_INIT(i,1);
        end
    plot(X_TRAJ_CORR_POS(i,:),Y_TRAJ_CORR_POS(i,:),'blue','linewidth',1.3);
        for j = 6:13
            X_HOME_CORR_POS(i,j-5) = X_HOME(i,j-5) - X_INIT(i,1);
            Y_HOME_CORR_POS(i,j-5) = Y_HOME(i,j-5) - Y_INIT(i,1);
        end
    plot(X_HOME_CORR_POS(i,:),Y_HOME_CORR_POS(i,:),'red','linewidth',1.3);
    plot([0 X_TRAJ_CORR_POS(i,1)],[0 Y_TRAJ_CORR_POS(i,1)],'blue','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(i,end) X_HOME_CORR_POS(i,1)],[Y_TRAJ_CORR_POS(i,end) Y_HOME_CORR_POS(i,1)],'red','linewidth',1.3);
    axis([-0.25 2.25 -1.75 1]);
    box on;
    axis equal;
    hold off;
    title(strcat('Test_{',num2str(i),'}'));
end
figure()
    hold on;
    plot(0,0,'black+','linewidth',1.2,'markersize',10);
    plot([0*ones(LENGTH,1) X_TRAJ_CORR_POS(:,1)]',[0*ones(LENGTH,1) Y_TRAJ_CORR_POS(:,1)]','blue','linewidth',1.3);
    plot(X_TRAJ_CORR_POS(:,:)',Y_TRAJ_CORR_POS(:,:)','blue','linewidth',1.3);
    plot(X_HOME_CORR_POS(:,:)',Y_HOME_CORR_POS(:,:)','red','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(:,end) X_HOME_CORR_POS(:,1)]',[Y_TRAJ_CORR_POS(:,end) Y_HOME_CORR_POS(:,1)]','red','linewidth',1.3);
            [A,c] = MinVolEllipse([X_HOME_CORR_POS(:,end) Y_HOME_CORR_POS(:,end)]',.001);
            Ellipse_plot(A,c);
            plot(c(1),c(2),'+','color',[0.2 0.5 0.4],'linewidth',1.4,'markersize',10);
    axis([-0.25 2.25 -1.75 1]); axis equal;
    hold off;
    box on;
    grid on;
    grid minor;
FullLengthPI_OF_ST = zeros(LENGTH,1);
X2 = [X_INIT X_TRAJ X_HOME];
Y2 = [Y_INIT Y_TRAJ Y_HOME];
for i = 1:LENGTH
    for j = 1:13
        FullLengthPI_OF_ST(i) = FullLengthPI_OF_ST(i) + sqrt((X2(i,j+1) - X2(i,j))^2 + (Y2(i,j+1) - Y2(i,j))^2);
    end
end
HomingDistPI_OF_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingDistPI_OF_ST(i) = sqrt((X_TRAJ(i,end) - X_INIT(i,1))^2 + (Y_TRAJ(i,end) - Y_INIT(i,1))^2);
end
HomingErrorPI_OF_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingErrorPI_OF_ST(i) = sqrt((X_HOME(i,end) - X_INIT(i,1))^2 + (Y_HOME(i,end) - Y_INIT(i,1))^2);
end
HomingPctPI_OF_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingPctPI_OF_ST(i) = HomingErrorPI_OF_ST(i) * 100 / FullLengthPI_OF_ST(i);
end    
%% PI-ST-FUSE
% According to this path integration mode, AntBot computes its travel
% distance using both the ventral optic flow and the stride integration, 
% and its heading using only the stride integration. 
% Mean distance per straight forward walking stride: 8.2cm
% Mean rotation per turning stride: 10.9°
% Raw Data :
X_INIT = FILE.PI_ST_FUSE.X(:,1);
Y_INIT = FILE.PI_ST_FUSE.Y(:,1);
X_TRAJ = FILE.PI_ST_FUSE.X(:,2:6);
Y_TRAJ = FILE.PI_ST_FUSE.Y(:,2:6);
X_HOME = FILE.PI_ST_FUSE.X(:,7:end);
Y_HOME = FILE.PI_ST_FUSE.Y(:,7:end);
% Variables for position corrected according to position init. :
X_TRAJ_CORR_POS = X_TRAJ;
Y_TRAJ_CORR_POS = Y_TRAJ;
X_HOME_CORR_POS = X_HOME;
Y_HOME_CORR_POS = Y_HOME;
figure()
for i = 1:LENGTH
    subplot(4,5,i)
    hold on;
    plot(0,0,'black*','linewidth',1.2);
        for j = 1:5
            X_TRAJ_CORR_POS(i,j) = X_TRAJ(i,j) - X_INIT(i,1);
            Y_TRAJ_CORR_POS(i,j) = Y_TRAJ(i,j) - Y_INIT(i,1);
        end
    plot(X_TRAJ_CORR_POS(i,:),Y_TRAJ_CORR_POS(i,:),'blue','linewidth',1.3);
        for j = 6:13
            X_HOME_CORR_POS(i,j-5) = X_HOME(i,j-5) - X_INIT(i,1);
            Y_HOME_CORR_POS(i,j-5) = Y_HOME(i,j-5) - Y_INIT(i,1);
        end
    plot(X_HOME_CORR_POS(i,:),Y_HOME_CORR_POS(i,:),'red','linewidth',1.3);
    plot([0 X_TRAJ_CORR_POS(i,1)],[0 Y_TRAJ_CORR_POS(i,1)],'blue','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(i,end) X_HOME_CORR_POS(i,1)],[Y_TRAJ_CORR_POS(i,end) Y_HOME_CORR_POS(i,1)],'red','linewidth',1.3);
    axis([-0.25 2.25 -1.75 1]);
    box on;
    axis equal;
    hold off;
    title(strcat('Test_{',num2str(i),'}'));
end
figure()
    hold on;
    plot(0,0,'black+','linewidth',1.2,'markersize',10);
    plot([0*ones(LENGTH,1) X_TRAJ_CORR_POS(:,1)]',[0*ones(LENGTH,1) Y_TRAJ_CORR_POS(:,1)]','blue','linewidth',1.3);
    plot(X_TRAJ_CORR_POS(:,:)',Y_TRAJ_CORR_POS(:,:)','blue','linewidth',1.3);
    plot(X_HOME_CORR_POS(:,:)',Y_HOME_CORR_POS(:,:)','red','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(:,end) X_HOME_CORR_POS(:,1)]',[Y_TRAJ_CORR_POS(:,end) Y_HOME_CORR_POS(:,1)]','red','linewidth',1.3);
            [A,c] = MinVolEllipse([X_HOME_CORR_POS(:,end) Y_HOME_CORR_POS(:,end)]',.001);
            Ellipse_plot(A,c);
            plot(c(1),c(2),'+','color',[0.2 0.5 0.4],'linewidth',1.4,'markersize',10);
    axis([-0.25 2.25 -1.75 1]); axis equal;
    hold off;
    box on;
    grid on;
    grid minor;
FullLengthPI_ST_FUSE = zeros(LENGTH,1);
X3 = [X_INIT X_TRAJ X_HOME];
Y3 = [Y_INIT Y_TRAJ Y_HOME];
for i = 1:LENGTH
    for j = 1:13
        FullLengthPI_ST_FUSE(i) = FullLengthPI_ST_FUSE(i) + sqrt((X3(i,j+1) - X3(i,j))^2 + (Y3(i,j+1) - Y3(i,j))^2);
    end
end
HomingDistPI_ST_FUSE = zeros(LENGTH,1);
for i=1:LENGTH
    HomingDistPI_ST_FUSE(i) = sqrt((X_TRAJ(i,end) - X_INIT(i,1))^2 + (Y_TRAJ(i,end) - Y_INIT(i,1))^2);
end
HomingErrorPI_ST_FUSE = zeros(LENGTH,1);
for i=1:LENGTH
    HomingErrorPI_ST_FUSE(i) = sqrt((X_HOME(i,end) - X_INIT(i,1))^2 + (Y_HOME(i,end) - Y_INIT(i,1))^2);
end
HomingPctPI_ST_FUSE = zeros(LENGTH,1);
for i=1:LENGTH
    HomingPctPI_ST_FUSE(i) = HomingErrorPI_ST_FUSE(i) * 100 / FullLengthPI_ST_FUSE(i);
end    
%% PI-POL-ST
% According to this path integration mode, AntBot computes its travel
% distance using the stride integration, and its heading using the 
% celestial compass. 
% Mean distance per straight forward walking stride: 8.2cm
% Mean rotation per turning stride: 10.9°
% Raw Data :
X_INIT = FILE.PI_POL_ST.X(:,1);
Y_INIT = FILE.PI_POL_ST.Y(:,1);
X_TRAJ = FILE.PI_POL_ST.X(:,2:6);
Y_TRAJ = FILE.PI_POL_ST.Y(:,2:6);
X_HOME = FILE.PI_POL_ST.X(:,7:end);
Y_HOME = FILE.PI_POL_ST.Y(:,7:end);
X_TRAJ_CORR_POS = X_TRAJ;
Y_TRAJ_CORR_POS = Y_TRAJ;
X_HOME_CORR_POS = X_HOME;
Y_HOME_CORR_POS = Y_HOME;
figure()
for i = 1:LENGTH
    subplot(4,5,i)
    hold on;
    plot(0,0,'black*','linewidth',1.2);
        for j = 1:5
            X_TRAJ_CORR_POS(i,j) = X_TRAJ(i,j) - X_INIT(i,1);
            Y_TRAJ_CORR_POS(i,j) = Y_TRAJ(i,j) - Y_INIT(i,1);
        end
    plot(X_TRAJ_CORR_POS(i,:),Y_TRAJ_CORR_POS(i,:),'blue','linewidth',1.3);
        for j = 6:13
            X_HOME_CORR_POS(i,j-5) = X_HOME(i,j-5) - X_INIT(i,1);
            Y_HOME_CORR_POS(i,j-5) = Y_HOME(i,j-5) - Y_INIT(i,1);
        end
    plot(X_HOME_CORR_POS(i,:),Y_HOME_CORR_POS(i,:),'red','linewidth',1.3);
    plot([0 X_TRAJ_CORR_POS(i,1)],[0 Y_TRAJ_CORR_POS(i,1)],'blue','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(i,end) X_HOME_CORR_POS(i,1)],[Y_TRAJ_CORR_POS(i,end) Y_HOME_CORR_POS(i,1)],'red','linewidth',1.3);
    axis([-0.25 2.25 -1.75 1]);
    box on;
    axis equal;
    hold off;
    title(strcat('Test_{',num2str(i),'}'));
end
figure()
    hold on;
    plot(0,0,'black+','linewidth',1.2,'markersize',10);
    plot([0*ones(LENGTH,1) X_TRAJ_CORR_POS(:,1)]',[0*ones(LENGTH,1) Y_TRAJ_CORR_POS(:,1)]','blue','linewidth',1.3);
    plot(X_TRAJ_CORR_POS(:,:)',Y_TRAJ_CORR_POS(:,:)','blue','linewidth',1.3);
    plot(X_HOME_CORR_POS(:,:)',Y_HOME_CORR_POS(:,:)','red','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(:,end) X_HOME_CORR_POS(:,1)]',[Y_TRAJ_CORR_POS(:,end) Y_HOME_CORR_POS(:,1)]','red','linewidth',1.3);
            [A,c] = MinVolEllipse([X_HOME_CORR_POS(:,end) Y_HOME_CORR_POS(:,end)]',.001);
            Ellipse_plot(A,c);
            plot(c(1),c(2),'+','color',[0.2 0.5 0.4],'linewidth',1.4,'markersize',10);
    axis([-0.25 2.25 -1.75 1]); axis equal;
    hold off;
    box on;
    grid on;
    grid minor;    
FullLengthPI_POL_ST = zeros(LENGTH,1);
X4 = [X_INIT X_TRAJ X_HOME];
Y4 = [Y_INIT Y_TRAJ Y_HOME];
for i = 1:LENGTH
    for j = 1:13
        FullLengthPI_POL_ST(i) = FullLengthPI_POL_ST(i) + sqrt((X4(i,j+1) - X4(i,j))^2 + (Y4(i,j+1) - Y4(i,j))^2);
    end
end
HomingDistPI_POL_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingDistPI_POL_ST(i) = sqrt((X_TRAJ(i,end) - X_INIT(i,1))^2 + (Y_TRAJ(i,end) - Y_INIT(i,1))^2);
end
HomingErrorPI_POL_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingErrorPI_POL_ST(i) = sqrt((X_HOME(i,end) - X_INIT(i,1))^2 + (Y_HOME(i,end) - Y_INIT(i,1))^2);
end
HomingPctPI_POL_ST = zeros(LENGTH,1);
for i=1:LENGTH
    HomingPctPI_POL_ST(i) = HomingErrorPI_POL_ST(i) * 100 / FullLengthPI_POL_ST(i);
end    
%% PI-FULL
% According to this path integration mode, AntBot computes its travel
% distance using both the ventral optic flow and the stride integration, 
% and its heading using the celestial compass. This is the true 
% ant-inspired path integration method. 
% Mean distance per straight forward walking stride: 8.2cm
% Mean rotation per turning stride: 10.9°
% Raw Data :
X_INIT = FILE.PI_FULL.X(:,1);
Y_INIT = FILE.PI_FULL.Y(:,1);
X_TRAJ = FILE.PI_FULL.X(:,2:6);
Y_TRAJ = FILE.PI_FULL.Y(:,2:6);
X_HOME = FILE.PI_FULL.X(:,7:end);
Y_HOME = FILE.PI_FULL.Y(:,7:end);
X_TRAJ_CORR_POS = X_TRAJ;
Y_TRAJ_CORR_POS = Y_TRAJ;
X_HOME_CORR_POS = X_HOME;
Y_HOME_CORR_POS = Y_HOME;
figure()
for i = 1:LENGTH
    subplot(4,5,i)
    hold on;
    plot(0,0,'black*','linewidth',1.2);
        for j = 1:5
            X_TRAJ_CORR_POS(i,j) = X_TRAJ(i,j) - X_INIT(i,1);
            Y_TRAJ_CORR_POS(i,j) = Y_TRAJ(i,j) - Y_INIT(i,1);
        end
    plot(X_TRAJ_CORR_POS(i,:),Y_TRAJ_CORR_POS(i,:),'blue','linewidth',1.3);
        for j = 6:13
            X_HOME_CORR_POS(i,j-5) = X_HOME(i,j-5) - X_INIT(i,1);
            Y_HOME_CORR_POS(i,j-5) = Y_HOME(i,j-5) - Y_INIT(i,1);
        end
    plot(X_HOME_CORR_POS(i,:),Y_HOME_CORR_POS(i,:),'red','linewidth',1.3);
    plot([0 X_TRAJ_CORR_POS(i,1)],[0 Y_TRAJ_CORR_POS(i,1)],'blue','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(i,end) X_HOME_CORR_POS(i,1)],[Y_TRAJ_CORR_POS(i,end) Y_HOME_CORR_POS(i,1)],'red','linewidth',1.3);
    axis([-0.25 2.25 -1.75 1]);
    box on;
    axis equal;
    hold off;
    title(strcat('Test_{',num2str(i),'}'));
end
figure()
    hold on;
    plot(0,0,'black+','linewidth',1.2,'markersize',10);
    plot([0*ones(LENGTH,1) X_TRAJ_CORR_POS(:,1)]',[0*ones(LENGTH,1) Y_TRAJ_CORR_POS(:,1)]','blue','linewidth',1.3);
    plot(X_TRAJ_CORR_POS(:,:)',Y_TRAJ_CORR_POS(:,:)','blue','linewidth',1.3);
    plot(X_HOME_CORR_POS(:,:)',Y_HOME_CORR_POS(:,:)','red','linewidth',1.3);
    plot([X_TRAJ_CORR_POS(:,end) X_HOME_CORR_POS(:,1)]',[Y_TRAJ_CORR_POS(:,end) Y_HOME_CORR_POS(:,1)]','red','linewidth',1.3);
            [A,c] = MinVolEllipse([X_HOME_CORR_POS(:,end) Y_HOME_CORR_POS(:,end)]',.001);
            Ellipse_plot(A,c);
            plot(c(1),c(2),'+','color',[0.2 0.5 0.4],'linewidth',1.4,'markersize',10);
    axis([-0.25 2.25 -1.75 1]); axis equal;
    hold off;
    box on;
    grid on;
    grid minor; 
FullLengthPI_FULL = zeros(LENGTH,1);
X5 = [X_INIT X_TRAJ X_HOME];
Y5 = [Y_INIT Y_TRAJ Y_HOME];
for i = 1:LENGTH
    for j = 1:13
        FullLengthPI_FULL(i) = FullLengthPI_FULL(i) + sqrt((X5(i,j+1) - X5(i,j))^2 + (Y5(i,j+1) - Y5(i,j))^2);
    end
end
HomingDistPI_FULL = zeros(LENGTH,1);
for i=1:LENGTH
    HomingDistPI_FULL(i) = sqrt((X_TRAJ(i,end) - X_INIT(i,1))^2 + (Y_TRAJ(i,end) - Y_INIT(i,1))^2);
end
HomingErrorPI_FULL = zeros(LENGTH,1);
for i=1:LENGTH
    HomingErrorPI_FULL(i) = sqrt((X_HOME(i,end) - X_INIT(i,1))^2 + (Y_HOME(i,end) - Y_INIT(i,1))^2);
end
HomingPctPI_FULL = zeros(LENGTH,1);
for i=1:LENGTH
    HomingPctPI_FULL(i) = HomingErrorPI_FULL(i) * 100 / FullLengthPI_FULL(i);
end    

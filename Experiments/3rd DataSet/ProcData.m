%% Loading
FILE = load('3rdExperiments.mat');
X = zeros(5,19);
Y = zeros(5,19);
X(1,:) = FILE.PI_ST.X;
X(2,:) = FILE.PI_OF_ST.X;
X(3,:) = FILE.PI_ST_FUSE.X;
X(4,:) = FILE.PI_POL_ST.X;
X(5,:) = FILE.PI_FULL.X;
Y(1,:) = FILE.PI_ST.Y;
Y(2,:) = FILE.PI_OF_ST.Y;
Y(3,:) = FILE.PI_ST_FUSE.Y;
Y(4,:) = FILE.PI_POL_ST.Y;
Y(5,:) = FILE.PI_FULL.Y;
X = X - X(:,1);
Y = Y - Y(:,1);
%% Dernière figure de résultats
figure()
    hold on;
        plot(X(1,1:11),Y(1,1:11),'green','linewidth',0.5);
        plot(X(2,1:11),Y(2,1:11),'magenta','linewidth',0.5);
        plot(X(3,1:11),Y(3,1:11),'yellow','linewidth',0.5);
        plot(X(4,1:11),Y(4,1:11),'red','linewidth',0.5);
        plot(X(5,1:11),Y(5,1:11),'blue','linewidth',0.5);
        plot(X(1,11:end),Y(1,11:end),'green','linewidth',1.5);
        plot(X(2,11:end),Y(2,11:end),'magenta','linewidth',1.5);
        plot(X(3,11:end),Y(3,11:end),'yellow','linewidth',1.5);
        plot(X(4,11:end),Y(4,11:end),'red','linewidth',1.5);
        plot(X(5,11:end),Y(5,11:end),'blue','linewidth',1.5);
        plot(0,0,'black+');
    hold off;
    axis equal;
    box on;
    grid on;
    grid minor;
    legend('PI-ST','PI-OF-ST','PI-ST-FUSE','PI-POL-ST','PI-FULL');

    
    
    
    
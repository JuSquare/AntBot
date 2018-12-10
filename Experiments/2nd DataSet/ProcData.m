%% Loading
Data = load('2ndExperiments.mat');
PI_ST = Data.PI_ST;
PI_OF_ST = Data.PI_OF_ST;
PI_ST_FUSE = Data.PI_ST_FUSE;
PI_POL_ST = Data.PI_POL_ST;
PI_FULL = Data.PI_FULL;
%% Figure
    for p = 1:5
        figure(p)
            hold on;
                plot(100*PI_ST.X(p,1:6),100*PI_ST.Y(p,1:6),'green','linewidth',0.5);
                plot(100*PI_OF_ST.X(p,1:6),100*PI_OF_ST.Y(p,1:6),'magenta','linewidth',0.5);
                plot(100*PI_ST_FUSE.X(p,1:6),100*PI_ST_FUSE.Y(p,1:6),'yellow','linewidth',0.5);
                plot(-PI_POL_ST.Y(p,1:6),-PI_POL_ST.X(p,1:6),'red','linewidth',0.5);
                plot(-PI_FULL.Y(p,1:6),-PI_FULL.X(p,1:6),'blue','linewidth',0.5);
                plot(100*PI_ST.X(p,6:end),100*PI_ST.Y(p,6:end),'green','linewidth',1.5);
                plot(100*PI_OF_ST.X(p,6:end),100*PI_OF_ST.Y(p,6:end),'magenta','linewidth',1.5);
                plot(100*PI_ST_FUSE.X(p,6:end),100*PI_ST_FUSE.Y(p,6:end),'yellow','linewidth',1.5);
                plot(-PI_POL_ST.Y(p,6:end),-PI_POL_ST.X(p,6:end),'red','linewidth',1.5);
                plot(-PI_FULL.Y(p,6:end),-PI_FULL.X(p,6:end),'blue','linewidth',1.5);
                plot(0,0,'black+');
            hold off;
            axis equal;
            box on;
            grid on;
            grid minor;
            legend('PI-ST','PI-OF-ST','PI-ST-FUSE','PI-POL-ST','PI-FULL');
    end
%% Statistics
ErreurCM = zeros(5,5);
ErreurCM(1,:) = PI_ST.ErreurCM;
ErreurCM(2,:) = PI_OF_ST.ErreurCM;
ErreurCM(3,:) = PI_ST_FUSE.ErreurCM;
ErreurCM(4,:) = PI_POL_ST.ErreurCM;
ErreurCM(5,:) = PI_FULL.ErreurCM;
ErreurPCT = zeros(5,5);
ErreurPCT(1,:) = PI_ST.ErreurPCT;
ErreurPCT(2,:) = PI_OF_ST.ErreurPCT;
ErreurPCT(3,:) = PI_ST_FUSE.ErreurPCT;
ErreurPCT(4,:) = PI_POL_ST.ErreurPCT;
ErreurPCT(5,:) = PI_FULL.ErreurPCT;
boxplot(ErreurPCT',{'PI-ST','PI-OF-ST','PI-ST-FUSE','PI-POL-ST','PI-FULL'});
box on;
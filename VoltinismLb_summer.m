%% VOLTINISMO INVIERNO 
%  Estefania Aguirre Zapata
% -------------------------------------------------------------------------

close all
clc

%% CARGA DE DATOS 
%   ET     LT     PT     AT      EH     LH    PH    AH
%SINTONIA 02
p=1.3e6*[5.5   2.58    4.5   9.5    1.58    0.045  .9 0.55]; %sintonia actual
%p=2.5e5*[5.5   2.58    4.5   9.5    1.58    0.045  .9 0.55]; % Pre multiplicando 0.5


% condicion inicial de hembras 
Avo =max(Vam_Prm);  

% Asignación
Tmax = Tmaxpoc_Vrn+deltaVrn*ones(length( Tmaxpoc_Vrn));
Tmin = Tminpoc_Vrn+deltaVrn*ones(length( Tmaxpoc_Vrn));


% Tasas de diferenciacion entre machos y hembras
Kam = 0.5;  
Kah = Kam;

% Inicialización de variables
ND = [0];   % Contador de días totales 
ContW = []; % Contador de iteraciones while 
Xs = [];    % Vector de estados  
tf = [];    % Vector de tiempo
TH_Vrn = []; TL_Vrn = [];  TP_Vrn = [];  TA_Vrn = []; 


  dl =14.15; %dl = 13.50; 
  Ebs_L =1*1.5;          % efectos del estado de las bayas en el tiempo de desarrollo de las larvas
  Ebs_P =1*1.5;          % efectos del estado de las bayas en el tiempo de desarrollo de las pupas

 % Condiciones iniciales para los estados
        Hv_Vrn(1) = 0;%50*(Kah*Avo); % Depende de la cantidad ovopositada por la G anterior
        Lv_Vrn(1) = 0;          % cero para el inicio de la generación
        Pv_Vrn(1) = 0;          % cero para el inicio de la generación
        Av_Vrn(1) = 0;          % cero para el inicio de la generación
        Tprom_Vrn = 26.85;

 % Parametros para ecuación de tasa de desarrollo 
GD_TH_Vrn(1)=GD_TH_Prm(end);
GD_TL_Vrn(1)=GD_TL_Prm(end);
GD_TP_Vrn(1)=GD_TP_Prm(end);
GD_TA_Vrn(1)=GD_TA_Prm(end); %1044.6;

%% SOLUCION DEL MODELO PARA INVIERNO
for i=2:139

             ND= i;

             dia=(Tmax(1,:)+ Tmin(1,:))/2;
             Tprom_Vrn=movmean(dia,MmovH);
             
             
            % Humedad 
             Humedad = Hpoc_Vrn(1,:)/100;   %Temperaturas máximas y mínimas
             H_Vrn_ = movmean(Humedad,Mmov);
             H_Vrn =  H_Vrn_(ND-1);

  %Tasas de mortalidad - Gilioli (2018)
%         TmL_E =11.6 ;  TmU_E = 34.79;
%         TmL_L =8.8;  TmU_L = 34.27;
%         TmL_P =10.35 ;  TmU_P = 32.67;
%         TmL_A =10.35 ;  TmU_A = 32.67;

        % Parametros de mortalidad 
        TMo_E = (TmL_E + TmU_E)/2; 
        TMo_L = (TmL_L + TmU_L)/2; 
        TMo_P = (TmL_P + TmU_P)/2; 
        TMo_A = (TmL_A + TmU_A)/2; 
       
        a_E = (Msat-Eps)*(((TmU_E /TMo_E)-1)^-2); 
        a_L = (Msat-Eps)*(((TmU_L /TMo_L)-1)^-2); 
        a_P = (Msat-Eps)*(((TmU_P /TMo_P)-1)^-2); 
        a_A = (Msat-Eps)*(((TmU_A /TMo_A)-1)^-2); 

        % Ecuaciones de mortalidad 

        % Huevos
        if (Tprom_Vrn(ND-1)  >= TmL_E) && (Tprom_Vrn(ND-1)  <=TmU_E)
            KHd_Vrn(ND-1) = a_E*(((Tprom_Vrn(ND-1) -TMo_E)/TMo_E)^2)+Eps ; 
        else
            KHd_Vrn(ND-1) = Msat;
        end

        % Larvas
        if (Tprom_Vrn(ND-1)  >= TmL_L) && (Tprom_Vrn(ND-1)  <=TmU_L)
            KLd_Vrn(ND-1) = a_L*(((Tprom_Vrn(ND-1) -TMo_L)/TMo_L)^2)+Eps ; 
        else
            KLd_Vrn(ND-1) = Msat;
        end

        % Pupas
        if (Tprom_Vrn(ND-1)  >= TmL_P) && (Tprom_Vrn(ND-1)  <=TmU_P)
            KPd_Vrn(ND-1)= a_P*(((Tprom_Vrn(ND-1) -TMo_P)/TMo_P)^2)+Eps ; 
        else
            KPd_Vrn(ND-1)= Msat;
        end

        % Adultos
        if (Tprom_Vrn(ND-1)  >= TmL_A) && (Tprom_Vrn(ND-1)  <=TmU_A)
            KAd_Vrn(ND-1)= a_A*(((Tprom_Vrn(ND-1) -TMo_A)/TMo_A)^2)+Eps ; 
        else
            KAd_Vrn(ND-1)= Msat;
        end

 % Calculo de parametros asociados a tasa de crecimiento

            % Calculo de mortalidad
            Hd= KHd_Vrn(ND-1)*Hv_Vrn(ND-1); 
            Ld= KLd_Vrn(ND-1)*Lv_Vrn(ND-1);
            Pd= KPd_Vrn(ND-1)*Pv_Vrn(ND-1);
            Ad= KAd_Vrn(ND-1)*Av_Vrn(ND-1);
            
            % calculo de tasas de Tasa de supervivencia especifica [adimensional]
            muHmax = 1-KHd_Vrn(ND-1); 
            muLmax = 1-KLd_Vrn(ND-1);
            muPmax = 1-KPd_Vrn(ND-1);
            muAmax = 1-KAd_Vrn(ND-1);
            %muAmax = 0.55;

            % Ecuación de touzeau Salas (2011)
            TH_Vrn(ND-1) = max(0,Tprom_Vrn(1,ND-1)-TmL_E);
            TL_Vrn(ND-1) = max(0,Tprom_Vrn(1,ND-1)-TmL_L);
            TP_Vrn(ND-1)= max(0,Tprom_Vrn(1,ND-1)-TmL_P);
            TA_Vrn(ND-1) = max(0,Tprom_Vrn(1,ND-1)-TmL_A);
            
            % Calculo de Grados dia acumulados
            GD_TH_Vrn(ND)=GD_TH_Vrn(ND-1)+ TH_Vrn(ND-1);
            GD_TL_Vrn(ND)=GD_TL_Vrn(ND-1)+ TL_Vrn(ND-1);
            GD_TP_Vrn(ND)=GD_TP_Vrn(ND-1)+ TP_Vrn(ND-1);
            GD_TA_Vrn(ND)=GD_TA_Vrn(ND-1)+ TA_Vrn(ND-1);

            %Tasas de crecimiento con humedad             
            kET = p(1);
            kLT = p(2); 
            kPT = p(3);
            kAT = p(4);
            kEH = p(5);        
            kLH = p(6);      
            kPH = p(7);        
            kAH = p(8);
            
 % Tasas de crecimiento con humedad   
 if dl > 14.15
    diap = 0;
 else 
    diap = 0.4565*(14.15-dl);
 end    
   % Ecuaciones de tasas de crecimiento

    KHT_Vrn(ND-1)= muHmax *((GD_TH_Vrn(ND-1))/ (kET + GD_TH_Vrn(ND-1)) );
    KHH_Vrn(ND-1) = muHmax *((H_Vrn)/ (kEH + H_Vrn));
    KH_Vrn(ND-1) =  KHT_Vrn(ND-1)+KHH_Vrn(ND-1);


    KLT_Vrn(ND-1)= muLmax *((GD_TL_Vrn(ND-1))/ (kLT + GD_TL_Vrn(ND-1)) );
    KLH_Vrn(ND-1) = muLmax *((H_Vrn)/ (kLH + H_Vrn));
    KL_Vrn(ND-1) =  KLT_Vrn(ND-1)+KLH_Vrn(ND-1)+Ebs_L;

    KPT_Vrn(ND-1)= muPmax *((GD_TP_Vrn(ND-1))/ (kPT + GD_TP_Vrn(ND-1)) );
    KPH_Vrn(ND-1) = muPmax *((H_Vrn)/ (kPH + H_Vrn));
    KP_Vrn(ND-1) =  KPT_Vrn(ND-1)+KPH_Vrn(ND-1)+Ebs_P;

    KAT_Vrn(ND-1)= muAmax *((GD_TA_Vrn(ND-1))/ (kAT + GD_TA_Vrn(ND-1)) );
    KAH_Vrn(ND-1) = muAmax *((H_Vrn)/ (kAH + H_Vrn));
    KA_Vrn(ND-1) =  KAT_Vrn(ND-1)+KAH_Vrn(ND-1);



            %% 
            % Calculo de ecuaciones de estado
            A_Vrn =Hv_Vrn(ND-1);


            if Tmax(ND-1) <= TmL_E 
                Tov(ND-1)=0 ;
                 Hv_Vrn(ND-1) = Tov(ND-1)*(Kah*Avo);
            else 
                 Tov(ND-1) =max(Pgamma*(i-1)/ Peta^(i-1),0);
                 Hv_Vrn(ND-1) = Tov(ND-1)*(Kah*Avo);
            end

             dHv_Vrn = -(KH_Vrn(ND-1)*Hv_Vrn(ND-1))-Hd;
            dLv_Vrn = (KL_Vrn(ND-1)*Hv_Vrn(ND-1))-Ld;
            dPv_Vrn = (KP_Vrn(ND-1)*Lv_Vrn(ND-1))-Pd;
            dAv_Vrn = (KA_Vrn(ND-1)*Pv_Vrn(ND-1))-Ad;
            
            dydt_Vrn =[dHv_Vrn;dLv_Vrn;dPv_Vrn;dAv_Vrn];
            
            % Solucionador de ecuaciones 
            h =1;
            Hv_Vrn(ND)=Hv_Vrn(ND-1)+h*dHv_Vrn;
            Lv_Vrn(ND)=Lv_Vrn(ND-1)+h*dLv_Vrn;
            Pv_Vrn(ND)=Pv_Vrn(ND-1)+h*dPv_Vrn;
            Av_Vrn(ND)=Av_Vrn(ND-1)+h*dAv_Vrn;
       
 

            % Almacenamiento de datos de vuelo y grados dia acumulados para
            % ploteo 
            Vam_Vrn  (ND,1)= (Kam*Av_Vrn(ND));
      end 
figure (1)
plot(Hv_Vrn,'b.-','linewidth',1), hold on, zoom on, grid on
xlabel('Tiempo (días)')
ylabel('Número de Huevos')
      
figure(2)
plot(Cpoc_Vrn,'k-','linewidth',4), hold on, zoom on, grid on
plot(Vam_Vrn,'b.-','linewidth',1), hold on, zoom on, grid on
legend('Capturas Pocito','Capturas modelo')
xlabel('Tiempo (días)')
ylabel('Número de adultos')

% figure(1)
% plot(Cpoc_Vrn,'k-','linewidth',4), hold on, zoom on, grid on
% plot(Vam,'b.-','linewidth',1), hold on, zoom on, grid on
% legend('Capturas Pocito','Capturas modelo')
% xlabel('Tiempo (días)')
% ylabel('Número de adultos')
% 
% figure(2)
% subplot(2,2,1)
% plot(Hv,'r.-','linewidth',1), hold on, zoom on, grid on
% ylabel('Número de huevos')
% 
% subplot(2,2,2)
% plot(Lv,'k.-','linewidth',1), hold on, zoom on, grid on
% ylabel('Número de larvas')
% 
% subplot(2,2,3)
% plot(Pv,'b.-','linewidth',1), hold on, zoom on, grid on
% ylabel('Número de pupas')
% 
% subplot(2,2,4)
% plot(Av,'g.-','linewidth',1), hold on, zoom on, grid on
% ylabel('Número de adultos')
% 
% figure(3)
% plot(Tprom,KHd(1,2:138),'k.-','linewidth',2), hold on, zoom on, grid on
% xlabel('Temperatura')
% ylabel('Tasa de mortalidad')
      

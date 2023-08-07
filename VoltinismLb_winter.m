%% VOLTINISMO INVIERNO 
%  Estefania Aguirre Zapata
% -------------------------------------------------------------------------

close all
clc


%% CARGA DE DATOS 

%p= 2.5e4*[0.5   0.25  0.5   2.5     .35   0.5  2.55 0.5]; %9.50.95
p= 1.5e6*[0.5   0.25  0.5   2.5     .35   0.5  2.55 0.5];
%Msat = 0.9;          % Saturación de mortalidad
%Eps = 0.44; % 0.28
%Peta= 1.11;
%Pgamma = 48.5;


% condicion inicial de hembras 
Avo =250;  %85

% Asignación
Tmax = Tmaxpoc_inv+deltaInv  *ones(length( Tmaxpoc_inv));
Tmin = Tminpoc_inv+deltaInv  *ones(length( Tmaxpoc_inv));

% Tasas de diferenciacion entre machos y hembras
Kam = 0.5;  
Kah = Kam;

% Inicialización de variables
ND = [0];   % Contador de días totales 
ContW = []; % Contador de iteraciones while 
Xs = [];    % Vector de estados  
tf = [];    % Vector de tiempo
TH_Inv = []; TL_Inv = [];  TP_Inv = [];  TA_Inv = []; 


  dl =11; %11;          % Horas dia invierno
  Ebs_L =1.25*1.1;          % efectos del estado de las bayas en el tiempo de desarrollo de las larvas 1.25;
  Ebs_P =1.19*1.1;          % efectos del estado de las bayas en el tiempo de desarrollo de las pupas 1.19;

 % Condiciones iniciales para los estados
        Hv_Inv(1) = 0; % Depende de la cantidad ovopositada por la G anterior
        Lv_Inv(1) = 0;          % cero para el inicio de la generación
        Pv_Inv(1) = 0;          % cero para el inicio de la generación
        Av_Inv(1) = 0;          % cero para el inicio de la generación
        Tprom_Inv = 10.36;

 % Parametros para ecuación de tasa de desarrollo 
GD_TH_Inv(1) =0; GD_TL_Inv(1) =0; GD_TP_Inv(1) =0; GD_TA_Inv(1) =0; 

%% SOLUCION DEL MODELO PARA INVIERNO
for i=2:101

         ND= i;
         dia=(Tmax(1,:)+ Tmin(1,:))/2;
         Tprom_Inv = movmean(dia,Mmov);
           
        % Humedad 
         Humedad = Hpoc_inv(1,:)/100;  
         H_Inv_ = movmean(Humedad,MmovH);
         H_Inv =  H_Inv_(ND-1);


 %Tasas de mortalidad - Gilioli (2018)

%         % Temperaturas umbral (up and low)
%         TmL_E =11.6 ;  TmU_E = 34.79;
%         TmL_L =8.8;     TmU_L = 34.27;
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
        if (Tprom_Inv(ND-1)  >= TmL_E) && (Tprom_Inv(ND-1)  <=TmU_E)
            KHd_Inv(ND-1) = a_E*(((Tprom_Inv(ND-1) -TMo_E)/TMo_E)^2)+Eps ; 
        else
            KHd_Inv(ND-1) = Msat;
        end

        % Larvas
        if (Tprom_Inv(ND-1)  >= TmL_L) && (Tprom_Inv(ND-1)  <=TmU_L)
            KLd_Inv(ND-1) = a_L*(((Tprom_Inv(ND-1) -TMo_L)/TMo_L)^2)+Eps ; 
        else
            KLd_Inv(ND-1) = Msat;
        end

        % Pupas
        if (Tprom_Inv(ND-1)  >= TmL_P) && (Tprom_Inv(ND-1)  <=TmU_P)
            KPd_Inv(ND-1) = a_P*(((Tprom_Inv(ND-1) -TMo_P)/TMo_P)^2)+Eps ; 
        else
            KPd_Inv(ND-1)= Msat;
        end

        % Adultos
        if (Tprom_Inv(ND-1)  >= TmL_A) && (Tprom_Inv(ND-1)  <=TmU_A)
            KAd_Inv(ND-1) = a_A*(((Tprom_Inv(ND-1) -TMo_A)/TMo_A)^2)+Eps ; 
        else
            KAd_Inv(ND-1)= Msat;
        end

 % Calculo de parametros asociados a tasa de crecimiento

            % Calculo de mortalidad
            Hd= KHd_Inv(ND-1)*Hv_Inv(ND-1); 
            Ld= KLd_Inv(ND-1)*Lv_Inv(ND-1);
            Pd= KPd_Inv(ND-1)*Pv_Inv(ND-1);
            Ad= KAd_Inv(ND-1)*Av_Inv(ND-1);
            
            % calculo de tasas de Tasa de supervivencia especifica [adimensional]
           
            muHmax = 1-KHd_Inv(ND-1); 
            muLmax = 1-KLd_Inv(ND-1);
            muPmax = 1-KPd_Inv(ND-1);
            muAmax = 1-KAd_Inv(ND-1);
            %muAmax = 0.55;
           
            % Ecuación de touzeau Salas (2011)
            TH_Inv(ND-1) = max(0,Tprom_Inv(1,ND-1)-TmL_E);
            TL_Inv(ND-1) = max(0,Tprom_Inv(1,ND-1)-TmL_L);
            TP_Inv(ND-1) = max(0,Tprom_Inv(1,ND-1)-TmL_P);
            TA_Inv(ND-1) = max(0,Tprom_Inv(1,ND-1)-TmL_A);

            % Calculo de Grados dia acumulados
            GD_TH_Inv(ND)=GD_TH_Inv(ND-1)+ TH_Inv(ND-1);
            GD_TL_Inv(ND)=GD_TL_Inv(ND-1)+ TL_Inv(ND-1);
            GD_TP_Inv(ND)=GD_TP_Inv(ND-1)+ TP_Inv(ND-1);
            GD_TA_Inv(ND)=GD_TA_Inv(ND-1)+ TA_Inv(ND-1);

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


   % Ecuaciones de tasas de crecimiento

    KHT_Inv(ND-1)= muHmax *((GD_TH_Inv(ND-1))/ (kET + GD_TH_Inv(ND-1)) );
    KHH_Inv(ND-1) = muHmax *((H_Inv)/ (kEH + H_Inv));
    KH_Inv(ND-1) =  KHT_Inv(ND-1)+KHH_Inv(ND-1);


    KLT_Inv(ND-1)= muLmax *((GD_TL_Inv(ND-1))/ (kLT + GD_TL_Inv(ND-1)) );
    KLH_Inv(ND-1) = muLmax *((H_Inv)/ (kLH + H_Inv));
    KL_Inv(ND-1) =  KLT_Inv(ND-1)+KLH_Inv(ND-1)+Ebs_L;

    KPT_Inv(ND-1)= muPmax *((GD_TP_Inv(ND-1))/ (kPT + GD_TP_Inv(ND-1)) );
    KPH_Inv(ND-1) = muPmax *((H_Inv)/ (kPH + H_Inv));
    KP_Inv(ND-1) =  KPT_Inv(ND-1)+KPH_Inv(ND-1)+Ebs_P;

    KAT_Inv(ND-1)= muAmax *((GD_TA_Inv(ND-1))/ (kAT + GD_TA_Inv(ND-1)) );
    KAH_Inv(ND-1) = muAmax *((H_Inv)/ (kAH + H_Inv));
    KA_Inv(ND-1) =  KAT_Inv(ND-1)+KAH_Inv(ND-1);


            %% 
            % Calculo de ecuaciones de estado
            A_Inv =Hv_Inv(ND-1);

            if Tmax(ND-1) <= TmL_E 
                Tov(ND-1)=0 ;
                 Hv_Inv(ND-1) = Tov(ND-1)*(Kah*Avo);
            else 
                 Tov(ND-1) = max(Pgamma*(i-1)/ Peta^(i-1),0);
                 Hv_Inv(ND-1) = Tov(ND-1)*(Kah*Avo);
            end

            dHv_Inv = -(KH_Inv(ND-1)*Hv_Inv(ND-1))-Hd;
            dLv_Inv = (KL_Inv(ND-1)*Hv_Inv(ND-1))-Ld;
            dPv_Inv = (KP_Inv(ND-1)*Lv_Inv(ND-1))-Pd;
            dAv_Inv = (KA_Inv(ND-1)*Pv_Inv(ND-1))-Ad;
            
            dydt_Inv =[dHv_Inv;dLv_Inv;dPv_Inv;dAv_Inv];
            
            % Solucionador de ecuaciones 
            h =1;
            Hv_Inv(ND)=Hv_Inv(ND-1)+h*dHv_Inv;
            Lv_Inv(ND)=Lv_Inv(ND-1)+h*dLv_Inv;
            Pv_Inv(ND)=Pv_Inv(ND-1)+h*dPv_Inv;
            Av_Inv(ND)=Av_Inv(ND-1)+h*dAv_Inv;

            % Almacenamiento de datos de vuelo y grados dia acumulados para
            % ploteo 
            Vam_Inv(ND,1)= (Kam*Av_Inv(ND));
      end 

figure (1)
plot(Hv_Inv,'b.-','linewidth',1), hold on, zoom on, grid on
xlabel('Tiempo (días)')
ylabel('Número de Huevos')
      
figure(2)
plot(Cpoc_Inv,'k-','linewidth',4), hold on, zoom on, grid on
plot(Vam_Inv,'b.-','linewidth',1), hold on, zoom on, grid on
legend('Capturas Pocito','Capturas modelo')
xlabel('Tiempo (días)')
ylabel('Número de adultos')


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
% plot(Vam,'g.-','linewidth',1), hold on, zoom on, grid on
% ylabel('Número de adultos')
% 
% 
% figure(3)
% plot(Tprom_,KHd,'k.-','linewidth',2), hold on, zoom on, grid on
% xlabel('Temperatura')
% ylabel('Tasa de mortalidad')
%       

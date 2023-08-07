%% VOLTINISMO INVIERNO 
%  Estefania Aguirre Zapata
% -------------------------------------------------------------------------

close all
clc

%% CARGA DE DATOS 


%SINTONIA 02
% p= 0.9e5*[10.5   1.5  0.005   18.5    .98    .25  4.2  7.95];
% Msat = 0.8;          % Saturación de mortalidad
% Eps = 0.28; % 0.28
% Peta= 1.15;
% Pgamma = 48.5;
%         ET     LT     PT      AT     EH     LH    PH     AH
p=2.4e5*[10.5   1.5  0.005   18.5    .98    .25  4.2  7.95];
%Msat = 0.9;          % Saturación de mortalidad
%Eps = 0.44; % 0.38
%Peta= 1.11;
%Pgamma = 48.5;

% condicion inicial de hembras 
Avo = max(Vam_Inv);  %68

% Asignación
Tmax = Tmaxpoc_Prm+deltaPrm *ones(length(Tmaxpoc_Prm));
Tmin = Tminpoc_Prm+deltaPrm *ones(length(Tmaxpoc_Prm));


% Tasas de diferenciacion entre machos y hembras
Kam = 0.5;  
Kah = Kam;

% Inicialización de variables
ND = [0];   % Contador de días totales 
ContW = []; % Contador de iteraciones while 
Xs = [];    % Vector de estados  
tf = [];    % Vector de tiempo
TH_Prm = []; TL_Prm = [];  TP_Prm = [];  TA_Prm = []; 


  dl =14.15; %dl = 13.20;
  Ebs_L =1.19*1.1;          % efectos del estado de las bayas en el tiempo de desarrollo de las larvas
  Ebs_P =1.14*1.1;          % efectos del estado de las bayas en el tiempo de desarrollo de las pupas

 % Condiciones iniciales para los estados
        Hv_Prm(1) = 0;%50*(Kah*Avo); % Depende de la cantidad ovopositada por la G anterior
        Lv_Prm(1) = 0;          % cero para el inicio de la generación
        Pv_Prm(1) = 0;          % cero para el inicio de la generación
        Av_Prm(1) = 0;          % cero para el inicio de la generación
        Tprom_Prm = 23.38;
        dl= 13.45 ;
 % Parametros para ecuación de tasa de desarrollo 
GD_TH_Prm(1)=GD_TH_Inv(end);
GD_TL_Prm(1)=GD_TL_Inv(end);
GD_TP_Prm(1)=GD_TP_Inv(end);
GD_TA_Prm(1)=GD_TA_Inv(end);

%% SOLUCION DEL MODELO PARA INVIERNO
for i=2:45

             ND= i;
             dia=(Tmax(1,:)+ Tmin(1,:))/2;
             Tprom_Prm= movmean(dia,Mmov);
             
             
            % Humedad 
             Humedad = Hpoc_Prm(1,:)/100;   %Temperaturas máximas y mínimas
             H_Prm_ = movmean(Humedad,MmovH);
             H_Prm =  H_Prm_(ND-1);

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
        if (Tprom_Prm(ND-1)  >= TmL_E) && (Tprom_Prm(ND-1)  <=TmU_E)
            KHd_Prm(ND-1)= a_E*(((Tprom_Prm(ND-1) -TMo_E)/TMo_E)^2)+Eps ; 
        else
            KHd_Prm(ND-1) = Msat;
        end

        % Larvas
        if (Tprom_Prm(ND-1)  >= TmL_L) && (Tprom_Prm(ND-1)  <=TmU_L)
            KLd_Prm(ND-1) = a_L*(((Tprom_Prm(ND-1) -TMo_L)/TMo_L)^2)+Eps ; 
        else
            KLd_Prm(ND-1) = Msat;
        end

        % Pupas
        if (Tprom_Prm(ND-1)  >= TmL_P) && (Tprom_Prm(ND-1)  <=TmU_P)
            KPd_Prm(ND-1) = a_P*(((Tprom_Prm(ND-1) -TMo_P)/TMo_P)^2)+Eps ; 
        else
            KPd_Prm(ND-1)= Msat;
        end

        % Adultos
        if (Tprom_Prm(ND-1)  >= TmL_A) && (Tprom_Prm(ND-1)  <=TmU_A)
            KAd_Prm(ND-1) = a_A*(((Tprom_Prm(ND-1) -TMo_A)/TMo_A)^2)+Eps ; 
        else
            KAd_Prm(ND-1)= Msat;
        end

 % Calculo de parametros asociados a tasa de crecimiento

            % Calculo de mortalidad
            Hd= KHd_Prm(ND-1)*Hv_Prm(ND-1); 
            Ld= KLd_Prm(ND-1)*Lv_Prm(ND-1);
            Pd= KPd_Prm(ND-1)*Pv_Prm(ND-1);
            Ad= KAd_Prm(ND-1)*Av_Prm(ND-1);
            
            % calculo de tasas de Tasa de supervivencia especifica [adimensional]
            muHmax = 1-KHd_Prm(ND-1); 
            muLmax = 1-KLd_Prm(ND-1);
            muPmax = 1-KPd_Prm(ND-1);
            muAmax = 1-KAd_Prm(ND-1);
            %muAmax = 0.55;
           
            % Ecuación de touzeau Salas (2011)
            TH_Prm(ND-1) = max(0,Tprom_Prm(1,ND-1)-TmL_E);
            TL_Prm(ND-1) = max(0,Tprom_Prm(1,ND-1)-TmL_L);
            TP_Prm(ND-1) = max(0,Tprom_Prm(1,ND-1)-TmL_P);
            TA_Prm(ND-1) = max(0,Tprom_Prm(1,ND-1)-TmL_A);
            
            
            % Calculo de Grados dia acumulados
            GD_TH_Prm(ND)=GD_TH_Prm(ND-1)+ TH_Prm(ND-1);
            GD_TL_Prm(ND)=GD_TL_Prm(ND-1)+ TL_Prm(ND-1);
            GD_TP_Prm(ND)=GD_TP_Prm(ND-1)+ TP_Prm(ND-1);
            GD_TA_Prm(ND)=GD_TA_Prm(ND-1)+ TA_Prm(ND-1);

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
    KHT_Prm(ND-1)= muHmax *((GD_TH_Prm(ND-1))/ (kET + GD_TH_Prm(ND-1)) );
    KHH_Prm(ND-1) = muHmax *((H_Prm)/ (kEH + H_Prm));
    KH_Prm(ND-1) =  KHT_Prm(ND-1)+KHH_Prm(ND-1);


    KLT_Prm(ND-1)= muLmax *((GD_TL_Prm(ND-1))/ (kLT + GD_TL_Prm(ND-1)) );
    KLH_Prm(ND-1) = muLmax *((H_Prm)/ (kLH + H_Prm));
    KL_Prm(ND-1) =  KLT_Prm(ND-1)+KLH_Prm(ND-1)+Ebs_L;

    KPT_Prm(ND-1)= muPmax *((GD_TP_Prm(ND-1))/ (kPT + GD_TP_Prm(ND-1)) );
    KPH_Prm(ND-1) = muPmax *((H_Inv)/ (kPH + H_Inv));
    KP_Prm(ND-1) =  KPT_Prm(ND-1)+KPH_Prm(ND-1)+Ebs_P;

    KAT_Prm(ND-1)= muAmax *((GD_TA_Prm(ND-1))/ (kAT + GD_TA_Prm(ND-1)) );
    KAH_Prm(ND-1) = muAmax *((H_Prm)/ (kAH + H_Prm));
    KA_Prm(ND-1) =  KAT_Prm(ND-1)+KAH_Prm(ND-1);



            %% 
            % Calculo de ecuaciones de estado
            A_Prm =Hv_Prm(ND-1);

            if Tmax(ND-1) <= TmL_E 
                Tov(ND-1)=0 ;
                 Hv_Prm(ND-1) = Tov(ND-1)*(Kah*Avo);
            else 
                 Tov(ND-1) = max(Pgamma*(i-1)/ Peta^(i-1),0);
                 Hv_Prm(ND-1) = Tov(ND-1)*(Kah*Avo);
            end

            dHv_Prm = -(KH_Prm(ND-1)*Hv_Prm(ND-1))-Hd;
            dLv_Prm = (KL_Prm(ND-1)*Hv_Prm(ND-1))-Ld;
            dPv_Prm = (KP_Prm(ND-1)*Lv_Prm(ND-1))-Pd;
            dAv_Prm = (KA_Prm(ND-1)*Pv_Prm(ND-1))-Ad;
            
            dydt_Prm =[dHv_Prm;dLv_Prm;dPv_Prm;dAv_Prm];
            
            % Solucionador de ecuaciones 
            h =1;
            Hv_Prm(ND)=Hv_Prm(ND-1)+h*dHv_Prm;
            Lv_Prm(ND)=Lv_Prm(ND-1)+h*dLv_Prm;
            Pv_Prm(ND)=Pv_Prm(ND-1)+h*dPv_Prm;
            Av_Prm(ND)=Av_Prm(ND-1)+h*dAv_Prm;
       
 

            % Almacenamiento de datos de vuelo y grados dia acumulados para
            % ploteo 
            Vam_Prm  (ND,1)= (Kam*Av_Prm(ND));
end 

figure (1)
plot(Hv_Prm,'b.-','linewidth',1), hold on, zoom on, grid on
xlabel('Tiempo (días)')
ylabel('Número de Huevos')
      
figure(2)
plot(Cpoc_Prm,'k-','linewidth',4), hold on, zoom on, grid on
plot(Vam_Prm,'b.-','linewidth',1), hold on, zoom on, grid on
legend('Capturas Pocito','Capturas modelo')
xlabel('Tiempo (días)')
ylabel('Número de adultos')

% figure(1)
% plot(Cpoc_Prm,'k-','linewidth',4), hold on, zoom on, grid on
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
% plot(Tprom,KHd(1,2:end),'k.-','linewidth',2), hold on, zoom on, grid on
% xlabel('Temperatura')
% ylabel('Tasa de mortalidad')
      
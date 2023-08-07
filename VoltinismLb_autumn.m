%% Autumn voltinism
%  Estefania Aguirre-Zapata
%  2023
% -------------------------------------------------------------------------

close all
clc

%% Initial conditions
p=6e4*[25.5   20.25  29.5    25.5   10.45  9.65  10.55 11.5];


% female initial condition
Avo =max(Vam_Vrn);  

% input data
Tmax = Tmaxpoc_Oto+deltaOto*ones(length(Tmaxpoc_Oto));
Tmin = Tminpoc_Oto+deltaOto*ones(length(Tmaxpoc_Oto));

% Differentiation rates between males and females
Kam = 0.5;  
Kah = Kam;

% Variable initialization
ND = [0];   % Days counter
ContW = []; % Iterations counter
Xs = [];    % States vector
tf = [];    % Time vector
TH_Oto = []; TL_Oto = [];  TP_Oto = [];  TA_Oto = []; 


  dl =14.15;  
  Ebs_L =1*1.1;          % effects of the state of the berries on the development time of the larvae
  Ebs_P =1*1.1;          % effects of the state of the berries on the development time of the pupae

 % Initial conditions for states
        Hv_Oto(1) = 0*(Kah*Avo);    % Depends on the amount oviposited by the previous G
        Lv_Oto(1) = 0;              % zero for start of generation
        Pv_Oto(1) = 0;              % zero for start of generation
        Av_Oto(1) = 0;              % zero for start of generation
        Tprom_Oto = 13.11;

 % Parameters for development rate equation
    GD_TH_Oto(1)=GD_TH_Vrn(end);
    GD_TL_Oto(1)=GD_TL_Vrn(end);
    GD_TP_Oto(1)=GD_TP_Vrn(end);
    GD_TA_Oto(1)=GD_TA_Vrn(end); 

446656546;112.051049554982];

%% Solving mathematical model
for i=2:82

             ND= i;
           dia=(Tmax(1,:)+ Tmin(1,:))/2;
             Tprom_Oto= movmean(dia,Mmov);

            % humidity 
             Humedad = Hpoc_Oto(1,:)/100;   
             H_Oto_ = movmean(Humedad,MmovH);
             H_Oto =  H_Oto_(ND-1);

        % mortality
        TMo_E = (TmL_E + TmU_E)/2; 
        TMo_L = (TmL_L + TmU_L)/2; 
        TMo_P = (TmL_P + TmU_P)/2; 
        TMo_A = (TmL_A + TmU_A)/2; 
       
        a_E = (Msat-Eps)*(((TmU_E /TMo_E)-1)^-2); 
        a_L = (Msat-Eps)*(((TmU_L /TMo_L)-1)^-2); 
        a_P = (Msat-Eps)*(((TmU_P /TMo_P)-1)^-2); 
        a_A = (Msat-Eps)*(((TmU_A /TMo_A)-1)^-2); 

       % Eggs
        if (Tprom_Oto(ND-1)  >= TmL_E) && (Tprom_Oto(ND-1)  <=TmU_E)
            KHd_Oto(ND-1) = a_E*(((Tprom_Oto(ND-1) -TMo_E)/TMo_E)^2)+Eps ; 
        else
            KHd_Oto(ND-1)= Msat;
        end

        % Larvae
        if (Tprom_Oto(ND-1)  >= TmL_L) && (Tprom_Oto(ND-1)  <=TmU_L)
            KLd_Oto(ND-1)= a_L*(((Tprom_Oto(ND-1) -TMo_L)/TMo_L)^2)+Eps ; 
        else
            KLd_Oto(ND-1)=Msat;
        end

        % Pupae
        if (Tprom_Oto(ND-1)  >= TmL_P) && (Tprom_Oto(ND-1)  <=TmU_P)
            KPd_Oto(ND-1)= a_P*(((Tprom_Oto(ND-1) -TMo_P)/TMo_P)^2)+Eps ; 
        else
            KPd_Oto(ND-1)= Msat;
        end

        % Adults
        if (Tprom_Oto(ND-1)  >= TmL_A) && (Tprom_Oto(ND-1)  <=TmU_A)
            KAd_Oto(ND-1)= a_A*(((Tprom_Oto(ND-1) -TMo_A)/TMo_A)^2)+Eps ; 
        else
            KAd_Oto(ND-1)=Msat;
        end

 % Calculation of parameters associated with growth rate

            % Mortality
            Hd= KHd_Oto(ND-1)*Hv_Oto(ND-1); 
            Ld= KLd_Oto(ND-1)*Lv_Oto(ND-1);
            Pd= KPd_Oto(ND-1)*Pv_Oto(ND-1);
            Ad= KAd_Oto(ND-1)*Av_Oto(ND-1);
            
            % calculo de tasas de Tasa de supervivencia especifica [adimensional]
            muHmax = 1-KHd_Oto(ND-1); 
            muLmax = 1-KLd_Oto(ND-1);
            muPmax = 1-KPd_Oto(ND-1);
            muAmax = 1-KAd_Oto(ND-1);
            %muAmax = 0.55;

            % Ecuación de touzeau Salas (2011)
            TH_Oto(ND-1) = max(0,Tprom_Oto(1,ND-1)-TmL_E);
            TL_Oto(ND-1)= max(0,Tprom_Oto(1,ND-1)-TmL_L);
            TP_Oto(ND-1)= max(0,Tprom_Oto(1,ND-1)-TmL_P);
            TA_Oto(ND-1)= max(0,Tprom_Oto(1,ND-1)-TmL_A);
            
            % Calculo de Grados dia acumulados
            GD_TH_Oto(ND)=GD_TH_Oto(ND-1)+ TH_Oto(ND-1);
            GD_TL_Oto(ND)=GD_TL_Oto(ND-1)+ TL_Oto(ND-1);
            GD_TP_Oto(ND)=GD_TP_Oto(ND-1)+ TP_Oto(ND-1);
            GD_TA_Oto(ND)=GD_TA_Oto(ND-1)+ TA_Oto(ND-1);

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

    KHT_Oto(ND-1)= muHmax *((GD_TH_Oto(ND-1))/ (kET + GD_TH_Oto(ND-1)) );
    KHH_Oto(ND-1) = muHmax *((H_Oto)/ (kEH + H_Oto));
    KH_Oto(ND-1) =  KHT_Oto(ND-1)+KHH_Oto(ND-1);


    KLT_Oto(ND-1)= muLmax *((GD_TL_Oto(ND-1))/ (kLT + GD_TL_Oto(ND-1)) );
    KLH_Oto(ND-1) = muLmax *((H_Oto)/ (kLH + H_Oto));
    KL_Oto(ND-1) =  KLT_Oto(ND-1)+KLH_Oto(ND-1)+Ebs_L;

    KPT_Oto(ND-1)= muPmax *((GD_TP_Oto(ND-1))/ (kPT + GD_TP_Oto(ND-1)) );
    KPH_Oto(ND-1) = muPmax *((H_Oto)/ (kPH + H_Oto));
    KP_Oto(ND-1) =  KPT_Oto(ND-1)+KPH_Oto(ND-1)+Ebs_P;

    KAT_Oto(ND-1)= muAmax *((GD_TA_Oto(ND-1))/ (kAT + GD_TA_Oto(ND-1)) );
    KAH_Oto(ND-1) = muAmax *((H_Oto)/ (kAH + H_Oto));
    KA_Oto(ND-1) =  KAT_Oto(ND-1)+KAH_Oto(ND-1);


            %% 
            % Calculo de ecuaciones de estado
            A_Oto =Hv_Oto(ND-1);

            if Tmax(ND-1) < TmL_E
                Tov(ND-1)=0 ;
                 Hv_Oto(ND-1) = Tov(ND-1)*(Kah*Avo);
            else 
                 Tov(ND-1) =max(Pgamma*(i-1)/ Peta^(i-1),0);
                 Hv_Oto(ND-1) = Tov(ND-1)*(Kah*Avo);
            end


            dHv_Oto = -(KH_Oto(ND-1)*Hv_Oto(ND-1))-Hd;
            dLv_Oto = (KL_Oto(ND-1)*Hv_Oto(ND-1))-Ld;
            dPv_Oto = (KP_Oto(ND-1)*Lv_Oto(ND-1))-Pd;
            dAv_Oto = (KA_Oto(ND-1)*Pv_Oto(ND-1))-Ad;
            
            dydt =[dHv_Oto;dLv_Oto;dPv_Oto;dAv_Oto];
            
            % Solucionador de ecuaciones 
            h =1;
            Hv_Oto(ND)=Hv_Oto(ND-1)+h*dHv_Oto;
            Lv_Oto(ND)=Lv_Oto(ND-1)+h*dLv_Oto;
            Pv_Oto(ND)=Pv_Oto(ND-1)+h*dPv_Oto;
            Av_Oto(ND)=Av_Oto(ND-1)+h*dAv_Oto;
       
            % Almacenamiento de datos de vuelo y grados dia acumulados para
            % ploteo 
            Vam_Oto  (ND,1)= (Kam*Av_Oto(ND));
      end 

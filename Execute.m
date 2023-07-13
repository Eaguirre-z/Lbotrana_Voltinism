%% Lobesia botrana Voltinism Model
% Parameterized for the region of Cuyo, Argentina
% All rights of the software are exclusive property of the owner - Estefania Aguirre Zapata 
% July 2023

clc
close all
clear all

%% Lobesia botrana field capture data load

% Actual season
Cpoc_suav = [ 12	12	12	12	12	12	12	37	37	37	37	37	37	37	101	101	101	101	101	101	101	155	155	155	155	155	155	155	127	127	127	127	127	127	127	249	249	249	249	249	249	249	504	504	504	504	504	504	504	580	580	580	580	580	580	580	1404	1404	1404	1404	1404	1404	1404	2079	2079	2079	2079	2079	2079	2079	1368	1368	1368	1368	1368	1368	1368	580	580	580	580	580	580	580	484	484	484	484	484	484	484	189	189	189	189	189	189	189	84	84	84	84	84	84	84	134	134	134	134	134	134	134	486	486	486	486	486	486	486	700	700	700	700	700	700	700	342	342	342	342	342	342	342	178	178	178	178	178	178	178	112	112	112	112	112	112	112	468	468	468	468	468	468	468	1226	1226	1226	1226	1226	1226	1226	1351	1351	1351	1351	1351	1351	1351	912	912	912	912	912	912	912	468	468	468	468	468	468	468	215	215	215	215	215	215	215	502	502	502	502	502	502	502	711	711	711	711	711	711	711	1203	1203	1203	1203	1203	1203	1203	1467	1467	1467	1467	1467	1467	1467	1172	1172	1172	1172	1172	1172	1172	652	652	652	652	652	652	652	674	674	674	674	674	674	674	1201	1201	1201	1201	1201	1201	1201	201	201	201	201	201	201	201	87	87	87	87	87	87	87	66	66	66	66	66	66	66	11	11	11	11	11	11	11	7	7	7	7	7	7	7	6	6	6	6	6	6	6	21	21	21	21	21	21	21	5	5	5	5	5	5	5	12	12	12	12	12	12	12	0	0	0	0	0	0	0	0	0	0	0	0	0	0	13	13	13	13	13	13	13	0	0	0	0	0	0	0	5	5	5	5	5	5	5	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];
A = smooth(Cpoc_suav,0.093,'sgolay');
Cpoc_fit = A';

% Previous season 
Cpoc_fit_2021 = [0.313385173136394 0.577646355737535 0.798005528252723 1.0375343279 2781 1.27152696498427 1.51260426397085 1.70047918177180 1.87800652755067 2.01557386951144 2.10834941624646 2.13731925922608 2.11370501482133 2.03432561848576 1.89339625251197 1.73087824298814 1.52616698101727 1.29884972019130 1.03989897512566 0.799090365676863 0.532506136575574 0.255945016945150 -0.0468736382794999 -0.329138223270675 -0.637329688381525 -0.952239407828121 -1.28214419006385 -1.57305517403866 -1.85487011540692 -2.09409160564376 -2.27214135754196 -2.34569678842162 -2.29824962774498 -2.08841002931861 -1.65821165909488 -1.01622019090476 -0.0625662730751435 1.23409616161414 2.97225691488548 5.04978532089071 7.65642622605480 10.7742899207110 14.4952970456853 18.5937700145876 23.2750104053780 28.4673450954926 34.2688405877567 40.5025265557709 47.4275592704881 55.0059940815946 63.2509273097505 72.1523506906296 81.7096677797670 91.9272966113076 102.774794905251 114.280011546465 126.285474107374 138.651108252648 151.033416786018 163.548395556383 175.650471690698 187.233435987069 197.881103412847 207.785808729598 216.074154248531 222.485952069754 226.629749257127 228.531890994495 227.922591131156 224.938864519207 219.956485688639 212.746033724132 204.281332009649 194.748623278009 184.833370128319 173.592011182843 162.393991960384 151.018346334182 140.134244819784 128.418122294115 117.483591689298 106.898214860436 97.2066245181370 86.8978547546567 77.5311411615104 68.6467309456817 60.7854987404968 52.5878337942101 45.4601097245837 38.9196008400076 33.3140392801267 27.5072725539007 22.6090218834471 18.9209787003651 14.7092767347675 11.1881986118352 8.44975551931944 6.56650006987736 4.64272693948115 3.35461125028050 2.73480811162545 2.65461840167537 3.16181249852565 4.37523205932911 6.12287485431222 7.99960001745419 11.1082185368241 14.8829027652641 18.9236036477737 22.5605993677707 27.9324249910225 33.8010952567452 39.6049066221127 44.3839100142969 50.9380923571006 57.4244456128360 63.2930961352355 67.6810927856825 73.2751782582009 78.2639579462840 82.2431486963890 84.7256237967225 87.1938278101853 88.4742195191753 88.5650739184442 87.9208185981124 86.0686683375918 83.2375261524593 79.8033772010700 76.8661590205877 72.3164184605725 67.3729327927943 62.3471535158107 58.5279988304235 53.0145090552332 47.4777433283618 42.2023854751877 38.4872681028350 33.4138062516636 28.7406082900258 25.9291956732048 22.3218132734402 19.6678446273852 18.2074847304509 18.0007730114902 18.9762832747287 21.6334703134262 26.0994536212319 30.1274285594468 37.7843655521549 47.4159808618209 59.0526579028918 67.9243391908678 82.8607432004692 99.6263673827432 117.961425194693 130.863056503497 150.950880825743 171.628663567595 192.576183670999 206.516473655616 227.068036433919 246.692036770309 264.708058361175 275.560879523801 289.913462142506 301.939223215084 311.833797017509 317.434767095145 324.748958278545 331.357341968876 337.893791725165 342.460475155713 349.887815954764 358.182115448382 367.360502712059 373.883007969701 384.000293023486 394.276745596739 404.669133401842 411.742056110662 422.826039065300 434.929210108026 443.875714213282 459.156242952423 477.259073238679 498.640681679619 514.821964442297 541.925054010826 572.050800382981 604.372645333295 626.519861318093 659.809383050238 692.629252589471 724.796115213075 745.969721648127 777.683807554840 809.976410643180 843.709629724595 867.417863384899 905.313457942852 946.395461621765 990.766812080022 1022.02152526349 1070.80129792726 1120.61764752117 1170.01168304217 1202.12958713461 1248.37592395903 1291.53720500711 1330.74686434930 1354.21915434721 1384.60190779363 1408.38187649617 1425.12470082352 1432.37673703528 1437.68410846996 1436.98867228372 1431.41933449363 1425.72522600180 1415.20809998647 1403.08296498881 1389.73530634522 1380.12716004384 1364.29310507971 1345.98128016756 1324.00413185826 1306.76744685382 1276.54757288561 1240.96710479519 1214.46252592292 1171.30512462873 1125.65966325697 1080.10485129714 1051.09435600150 1011.00807899471 976.050266934861 946.714507816472 930.239815493087 909.713356363697 893.283075044457 879.675930531447 871.537876048684 859.803458993638 847.577910123348 833.758110762632 823.170198061092 804.598079338227 782.183141366202 755.405738116110 734.981038008439 700.463026387787 661.567516990852 619.028079338916 589.249618460841 543.451762196260 497.183925581737 451.169622081573 420.902526377693 376.459952196274 333.598544960929 292.910482845467 267.264721296492 231.231607458039 198.203253385561 168.153869821177 149.737833082572 124.493495432194 102.114681000174 82.6097559766448 71.1509063589190 56.1376785806351 43.5213403617514 33.0468156958642 27.1328747790312 19.7089719008711 13.8513222612266 10.7168014652511 7.02021986985401 4.35682320518586 2.54854348950318 1.74111719223853 1.03091408219480 0.824743999896309 1.01923981499657 1.32292286017220 1.97005079456637 2.76713528761448 3.62646055662204 4.19093441517469 4.96579432917633 5.60268189001024 6.06455478387632 6.26683863086476 6.41308416733638 6.38862994095715 6.23136052980528 6.07695551424482 5.80630114408140 5.52893706886685 5.28818069205351 5.16876183784551 5.08181578936605 5.14176439097607 5.38524651561278 5.66211577819951 6.25883374184172 7.07254941757050 8.08755763289198 8.86005904007509 10.1248236182700 11.4631014080020 12.8278016929527 13.7355943114952 15.0767901976544 16.3789817978873 17.6302668090137 18.4311232633962 19.5740517242983 20.6335895955140 21.2937730051462 22.1522997390336 22.8591687220411 23.3527219256154 23.5339167770750 23.5208159814879 23.1370884850758 22.3645644606613 21.6121974225622 20.2776579530638 18.6530613306374 16.8859875020613 15.6455126399428 13.9922053932825 12.4529625980108 11.1439727994424 10.3827398865231 9.56855863529812 9.00513726075608 8.71933035738393 8.67739156334446 8.82128812748140 9.20260092666982 9.80088102052679 10.3503977645333 11.2169731151528 12.2714248181749 13.4405325014835 14.3369573620701 15.5446939827611 16.8274937150699 18.0552452897501 18.8736554931113 19.7749250633532 20.4975570537595 20.9390559717886 21.0768782134126 21.0300541365031 20.7300105890894 20.2212197239459 19.7472122277876 19.0793434445512 18.2966423933373 17.4804896588030 16.8597210045656];
Cpoc_suav_2021 = [0	0	0	0	0	0	0	4	4	4	4	4	4	4	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	36	36	36	36	36	36	36	75	75	75	75	75	75	75	158	158	158	158	158	158	158	296	296	296	296	296	296	296	162	162	162	162	162	162	162	100	100	100	100	100	100	100	41	41	41	41	41	41	41	13	13	13	13	13	13	13	0	0	0	0	0	0	0	14	14	14	14	14	14	14	62	62	62	62	62	62	62	113	113	113	113	113	113	113	65	65	65	65	65	65	65	47	47	47	47	47	47	47	7	7	7	7	7	7	7	34	34	34	34	34	34	34	156	156	156	156	156	156	156	380	380	380	380	380	380	380	275	275	275	275	275	275	275	481	481	481	481	481	481	481	373	373	373	373	373	373	373	847	847	847	847	847	847	847	768	768	768	768	768	768	768	1250	1250	1250	1250	1250	1250	1250	1590	1590	1590	1590	1590	1590	1590	1214	1214	1214	1214	1214	1214	1214	1523	1523	1523	1523	1523	1523	1523	735	735	735	735	735	735	735	896	896	896	896	896	896	896	875	875	875	875	875	875	875	424	424	424	424	424	424	424	179	179	179	179	179	179	179	49	49	49	49	49	49	49	14	14	14	14	14	14	14	3	3	3	3	3	3	3	14	14	14	14	14	14	14	5	5	5	5	5	5	5	0	0	0	0	0	0	0	17	17	17	17	17	17	17	17	17	17	17	17	17	17	36	36	36	36	36	36	36	3	3	3	3	3	3	3	8	8	8	8	8	8	8	11	11	11	11	11	11	11	30	30	30	30	30	30	30	14	14	14	14	14	14	14];

%% General model parameters 
% General parameters are those that do not vary from one season to another.

% Sampling time
ts1 =1 ;

% Constant parameters for all seasons
Mmov =25; 
MmovH =10; 
Pgamma = 38.5;
Eps = 0.046; 
Peta= 1.11; 
Msat = 0.9; 
deltaInv =5.5;
deltaPrm =6; 
deltaVrn =-2.5; 
deltaOto =-2.5; 

% threshold temperatures (up and low)
TmL_E =11.6 ;  TmU_E = 32.5;
TmL_L =8.8;    TmU_L = 34.27;
TmL_P =10.35 ; TmU_P = 32.67;
TmL_A =10.35 ; TmU_A = 32.67;

% Data selection by season of the year        
Cpoc_Inv = Cpoc_suav(1:100); 
Cpoc_Prm = Cpoc_suav(101:144); 
Cpoc_Vrn = Cpoc_suav(145:283); 
Cpoc_Oto = Cpoc_suav(284:364); 

%% Model inputs load

 % Maximum temperature
load ('Tmaxpoc');   
Tmaxpoc_inv= Tmaxpoc(1:100);
Tmaxpoc_Prm= Tmaxpoc(101:144);
Tmaxpoc_Vrn= Tmaxpoc(145:283);
Tmaxpoc_Oto= Tmaxpoc(284:364);

% Minimum temperature
load ('Tminpoc');    
Tminpoc_inv= Tminpoc(1:100);
Tminpoc_Prm= Tminpoc(101:144);
Tminpoc_Vrn= Tminpoc(145:283);
Tminpoc_Oto= Tminpoc(284:364);

% Relative humidity
load ('Hpoc');      
Hpoc_inv = Hpoc(1:100);
Hpoc_Prm = Hpoc(101:144);
Hpoc_Vrn = Hpoc(145:283);
Hpoc_Oto = Hpoc(284:364);

%% Data processing for graphing

% Autumn
t_ot = 1:1:length(Cpoc_Oto);
DatosExp_ot = double([t_ot',Cpoc_Oto']);
Tmaxpoc_ot = double([t_ot',Tmaxpoc_Oto']);
Tminpoc_ot = double([t_ot',Tminpoc_Oto']);
Hpoc_ot = double([t_ot',Hpoc_Oto']);

% Winter
t_in = 1:1:length(Cpoc_Inv);
DatosExp = double([t_in',Cpoc_Inv']);
Tmaxpoc_in = double([t_in',Tmaxpoc_inv']);
Tminpoc_in = double([t_in',Tminpoc_inv']);
Hpoc_in = double([t_in',Hpoc_inv']);

% Spring
t_pr = 1:1:length(Cpoc_Prm);
DatosExp_pr = double([t_pr',Cpoc_Prm']);
Tmaxpoc_pr = double([t_pr',Tmaxpoc_Prm']);
Tminpoc_pr = double([t_pr',Tminpoc_Prm']);
Hpoc_pr = double([t_pr',Hpoc_Prm']);

% Summer
t_vr = 1:1:length(Cpoc_Vrn);
DatosExp_vr = double([t_vr',Cpoc_Vrn']);
Tmaxpoc_vr = double([t_vr',Tmaxpoc_Vrn']);
Tminpoc_vr = double([t_vr',Tminpoc_Vrn']);
Hpoc_vr = double([t_vr',Hpoc_Vrn']);

%% Mathematical model simulation

% Model simulation by seasons
run VoltinismLb_winter.m
run VoltinismLb_spring.m
run VoltinismLb_summer.m
run VoltinismLb_autumn.m

%% Pre-processing of simulation data for graphing

% Data Concatenation
t = length(Cpoc_suav);
tt = 1:1:t;
Av = [Av_Inv Av_Prm Av_Vrn Av_Oto];
Volt= [Vam_Inv;Vam_Prm;Vam_Vrn;Vam_Oto];
Ev_f= [Hv_Inv';Hv_Prm';Hv_Vrn';Hv_Oto'];
Lv_f= [Lv_Inv';Lv_Prm';Lv_Vrn';Lv_Oto'];
Pv_f= [Pv_Inv';Pv_Prm';Pv_Vrn';Pv_Oto'];
GDAA = [GD_TA_Inv';GD_TA_Prm';GD_TA_Vrn';GD_TA_Oto'];
KAD = [KAd_Inv';KAd_Prm';KAd_Vrn';KAd_Oto'];
KHD = [KHd_Inv';KHd_Prm';KHd_Vrn';KHd_Oto'];
KPD = [KPd_Inv';KPd_Prm';KPd_Vrn';KPd_Oto'];
KLD = [KLd_Inv';KLd_Prm';KLd_Vrn';KLd_Oto'];

TpromT = [Tprom_Inv Tprom_Prm Tprom_Vrn Tprom_Oto];
HT = [H_Inv_ H_Prm_ H_Vrn_ H_Oto_];

KH_T = [KHT_Inv';KHT_Prm';KHT_Vrn';KHT_Oto'];
KL_T = [KLT_Inv';KLT_Prm';KLT_Vrn';KLT_Oto'];
KP_T = [KPT_Inv';KPT_Prm';KPT_Vrn';KPT_Oto'];
KA_T = [KAT_Inv';KAT_Prm';KAT_Vrn';KAT_Oto'];

KDT = [TpromT(1:end-1)' KH_T KL_T KP_T KA_T];

KH_H = sort([HT(1:end-1)' [KHH_Inv';KHH_Prm';KHH_Vrn';KHH_Oto']],'ascend');
KL_H = sort([HT(1:end-1)' [KLH_Inv';KLH_Prm';KLH_Vrn';KLH_Oto']],'ascend');
KP_H = sort([HT(1:end-1)' [KPH_Inv';KPH_Prm';KPH_Vrn';KPH_Oto']],'ascend');
KA_H = sort([HT(1:end-1)' [KAH_Inv';KAH_Prm';KAH_Vrn';KAH_Oto']],'ascend');

KH= [KH_Inv';KH_Prm';KH_Vrn';KH_Oto'];
KL = [KL_Inv';KL_Prm';KL_Vrn';KL_Oto'];
KP = [KP_Inv';KP_Prm';KP_Vrn';KP_Oto'];
KA= [KA_Inv';KA_Prm';KA_Vrn';KA_Oto'];

KH_Td = [TpromT(1:end-1)' [KHd_Inv';KHd_Prm';KHd_Vrn';KHd_Oto']];
KL_Td = [TpromT(1:end-1)' [KLd_Inv';KLd_Prm';KLd_Vrn';KLd_Oto']];
KP_Td = [TpromT(1:end-1)' [KPd_Inv';KPd_Prm';KPd_Vrn';KPd_Oto']];
KA_Td = [TpromT(1:end-1)' [KAd_Inv';KAd_Prm';KAd_Vrn';KAd_Oto']];

KTd = [TpromT(1:end-1)' KHD KLD KPD KAD];


%% Figures

Time=1:1:length(Cpoc_suav);

figure(1)
yyaxis left;
plot(GDAA,'b.-','linewidth',1), hold on, zoom on, grid on
ylabel('Accumulated degree days')
yyaxis right; 
plot(Volt,'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of adults')


% % GRADOS DIA VS CAPTURAS 
figure(2)
yyaxis left;
plot(GDAA,'b.-','linewidth',1), hold on, zoom on, grid on
ylabel('Accumulated degree days')
yyaxis right; 
plot(Cpoc_suav,'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of adults')


%% Standard deviation and confidence interval 
VarVolt = var(Cpoc_fit);
stdVolt=sqrt(VarVolt); 
Volt_up  = Cpoc_fit + 0.5*stdVolt;
Volt_low = Cpoc_fit - 0.5*stdVolt;

figure(3)
X=[ Time Time(end:-1:1)]; Y=[Volt_up Volt_low(end:-1:1)];
fill(X,Y,[0.85 0.85 0.85]); hold on; grid on; 
plot(Cpoc_suav,'k-','linewidth',4), hold on, zoom on, grid on
plot(Volt(1:1:length(Cpoc_suav)),'r.-','linewidth',1), hold on, zoom on, grid on
legend('Confidence interval','Field captures','Model captures')
xlabel('Time [days]')
ylabel('Number of adults[males]')
title ('Validation-Season 2021-2022')

dia_org=(Tmaxpoc(1,:)+ Tminpoc(1,:))/2;   
TpromOriginal =  movmean(dia_org,Mmov);
Humedad_org2021= movmean(Hpoc,Mmov);

figure(4)
plot(dia_org,'k.-','linewidth',3), hold on, zoom on, grid on
plot(TpromOriginal,'b.-','linewidth',1)
plot(TpromT,'r.-','linewidth',1)
ylabel('Temperature')
xlabel('Time')
legend('field average temperature','moving average temperature','+- error temperature')

figure(5)
plot(Hpoc,'k.-','linewidth',1), hold on, zoom on, grid on
plot(Humedad_org2021,'b.-','linewidth',1)
ylabel('Relative humidity')
xlabel('Time')
legend('Field average humidity','Moving average humidity')


% TASAS DE MORTALIDAD VS TEMPERATURA 
figure(6)
subplot(2,2,1)
plot(KTd(:,1),KTd(:,2),'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Mortality rate')
xlabel('Temperature')

subplot(2,2,2)
plot(KTd(:,1),KTd(:,3),'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Mortality rate')
xlabel('Temperature')

subplot(2,2,3)
plot(KTd(:,1),KTd(:,4),'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Mortality rate')
xlabel('Temperature')

subplot(2,2,4)
plot(KTd(:,1),KTd(:,5),'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Mortality rate')
xlabel('Temperature')

%% Comparative figures 

load('dia_org2021')

figure(7)
plot(dia_org2021,'b.-','linewidth',1), hold on, zoom on, grid on
plot(dia_org,'r.-','linewidth',1)
ylabel('Temperature')
xlabel('Time')
legend('Average temperature 2020-2021','Average temperature 2021-2022')

figure(8)
plot(Time,Cpoc_suav_2021,'k.-','linewidth',2), hold on, zoom on, grid on
plot(Time,Cpoc_suav,'r.-','linewidth',2)
ylabel('Field captures')
xlabel('Time')
legend('Fiel captures 2020-2021','Field captures 2021-2022')

%% All states
figure(9)
subplot(2,2,1)
plot(Ev_f,'k.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of eggs')
xlabel('Temperature')

subplot(2,2,2)
plot(Lv_f,'b.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of larvae')
xlabel('Temperature')

subplot(2,2,3)
plot(Pv_f,'m.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of pupae')
xlabel('Temperature')

subplot(2,2,4)
plot(Cpoc_suav,'k-','linewidth',4), hold on, zoom on, grid on
plot(Volt,'r.-','linewidth',1), hold on, zoom on, grid on
ylabel('Number of adults')
xlabel('Temperature')

%% Error 
Ee11= abs(Volt(1:length(Cpoc_suav)) - Cpoc_suav');
Ee11_s= Ee11;
MAE= sum(Ee11_s)/length(Ee11)
for i=1:length(Cpoc_suav)
  VMAEper (i)=(Ee11(i)/max(Cpoc_suav))*100;
end
MAEper = (MAE/max(Cpoc_suav))*100
MaxMAEp = max(VMAEper)
MinMAEp = min(VMAEper)

%% Lin coefficient
Volt_d =Volt(1:length(Cpoc_suav));
   Mean_x=mean(Volt_d); 
   Mean_y=mean(Cpoc_suav);
   Var_x=var(Volt_d,1); 
   Var_y=var(Cpoc_suav,1); 
   Cov_xy=sum(Volt_d'.*Cpoc_suav)/length(Cpoc_suav)-Mean_x*Mean_y;
   Coef_con=2*Cov_xy/(Var_x+Var_y+(Mean_x-Mean_y)^2)

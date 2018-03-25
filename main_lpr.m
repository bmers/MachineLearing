function varargout = main_lpr(varargin)
% MAIN_LPR MATLAB code for main_lpr.fig
%      MAIN_LPR, by itself, creates a new MAIN_LPR or raises the existing
%      singleton*.
%
%      H = MAIN_LPR returns the handle to a new MAIN_LPR or the handle to
%      the existing singleton*.
%
%      MAIN_LPR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_LPR.M with the given input arguments.
%
%      MAIN_LPR('Property','Value',...) creates a new MAIN_LPR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_lpr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_lpr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_lpr

% Last Modified by GUIDE v2.5 03-Jan-2018 23:58:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_lpr_OpeningFcn, ...
                   'gui_OutputFcn',  @main_lpr_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main_lpr is made visible.
function main_lpr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_lpr (see VARARGIN)

% Choose default command line output for main_lpr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_lpr wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.axes1),cla reset ;imshow('initial.jpg');
axes(handles.axes2),cla reset ;imshow('initial.jpg');
axes(handles.axes3),cla reset ;imshow('initial.jpg');
axes(handles.axes4),cla reset ;imshow('initial.jpg');
axes(handles.axes5),cla reset ;imshow('initial.jpg');
axes(handles.axes6),cla reset ;imshow('initial.jpg');
axes(handles.axes7),cla reset ;imshow('initial.jpg');
axes(handles.axes8),cla reset ;imshow('initial.jpg');
axes(handles.axes9),cla reset ;imshow('initial.jpg');
set(handles.pushbutton3,'Enable','off');
set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton5,'Enable','off');
set(handles.pushbutton8,'Enable','off');
set(handles.pushbutton9,'Enable','off');
set(handles.pushbutton10,'Enable','off');
% --- Outputs from this function are returned to the command line.
function varargout = main_lpr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_car
axes(handles.axes1),cla reset ;imshow('initial.jpg');
axes(handles.axes2),cla reset ;imshow('initial.jpg');
axes(handles.axes3),cla reset ;imshow('initial.jpg');
axes(handles.axes4),cla reset ;imshow('initial.jpg');
axes(handles.axes5),cla reset ;imshow('initial.jpg');
axes(handles.axes6),cla reset ;imshow('initial.jpg');
axes(handles.axes7),cla reset ;imshow('initial.jpg');
axes(handles.axes8),cla reset ;imshow('initial.jpg');
axes(handles.axes9),cla reset ;imshow('initial.jpg');
set(handles.edit1,'String','');
[filename,pathname]=uigetfile(...
                {'*.bmp;*.jpg;*.png;*.jpeg','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';... 
                              '*.*',             'AllFiles(*.*)'},...
                              'Pickanimage');
if isequal(filename,0)||isequal(pathname,0),
    return;
end
axes(handles.axes1);%用axes命令设置当前操作的坐标轴为oimage_axes
fpath=[pathname filename];
image_car = imread(fpath);
imshow(image_car);
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton5,'Enable','off');
set(handles.pushbutton8,'Enable','off');
set(handles.pushbutton9,'Enable','off');
set(handles.pushbutton10,'Enable','off');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_car dw PY1 PY2 PX1 PX2
[y,x,z]=size(image_car);
[PY2,PY1,PX2,PX1]=Pre_Process(image_car);
area_ratio=(PY2-PY1)*(PX2-PX1)/(y*x);
 if area_ratio>=0.15
[PY2,PY1,PX2,PX1]=Pre_Process2(image_car);%蓝色车用游程统计的方法确定xy
 elseif area_ratio<=0.001
         msgbox('对不起，无法识别','warning');
           pause;
 end
 hold on;
        line1 = [1 PY1; x PY1];
        plot(line1(:, 1), line1(:, 2), 'y-', 'LineWidth', 2);pause(0.8);
    hold on;
        line2 = [1 PY2; x PY2];
        plot(line2(:, 1), line2(:, 2), 'r-', 'LineWidth', 2);pause(0.8);
    hold on;
        line3 = [PX1 1; PX1 y];
        plot(line3(:, 1), line3(:, 2), 'g-', 'LineWidth', 2);pause(0.8);
    hold on;
        line4 = [PX2 1; PX2 y];
        plot(line4(:, 1), line4(:, 2), 'b-', 'LineWidth', 2);
dw=image_car(PY1:PY2,PX1:PX2);%求得车牌区域
axes(handles.axes2);%设置当前坐标轴
imshow(dw);
set(handles.pushbutton4,'Enable','on');
set(handles.pushbutton5,'Enable','off');
set(handles.pushbutton8,'Enable','off');
set(handles.pushbutton9,'Enable','off');
set(handles.pushbutton10,'Enable','off');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  dd PY1 PY2 PX1 PX2 image_car
i2=imcrop(image_car,[PX1,PY1,PX2-PX1,PY2-PY1]);
[py2,py1,px2,px1]=Locate_last(i2);
% dd=image_car(PY1:PY2,PX1:PX2);
dd=i2(py1:py2,px1:px2);
imshow(dd);
set(handles.pushbutton5,'Enable','on');
set(handles.pushbutton8,'Enable','off');
set(handles.pushbutton9,'Enable','off');
set(handles.pushbutton10,'Enable','off');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dd bw rw
g_max=double(max(max(dd)));
g_min=double(min(min(dd)));
T=round(g_max-(g_max-g_min)/2); % T 为二值化的阈值
bw=(double(dd)>=T);  % d:二值图像
bw = bwareaopen(bw, 200);
bw=~bw; 
imshow(bw);
set(handles.pushbutton8,'Enable','on');
set(handles.pushbutton9,'Enable','off');
set(handles.pushbutton10,'Enable','off');

% i7=edge(dd);
% theta = 0:180; %先提取图片的轮廓，再用radon变换计算计算图片中的线条的角度，提取最大的倾斜角，对图片进行旋转处理，得到校正后的图片！
% [R,xp] = radon(i7,theta);
% [I,J] = find(R>=max(max(R)));%J记录了倾斜角
% qingxiejiao=90-J;
% rw=imrotate(dd,qingxiejiao,'bilinear','crop');
% imshow(rw);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw rw 
i7=edge(bw);
theta = 0:180; %先提取图片的轮廓，再用radon变换计算计算图片中的线条的角度，提取最大的倾斜角，对图片进行旋转处理，得到校正后的图片！
[R,xp] = radon(i7,theta);
[I,J] = find(R>=max(max(R)));%J记录了倾斜角
qingxiejiao=90-J;
rw=imrotate(bw,qingxiejiao,'bilinear','crop');
imshow(rw);

% global dd bw rw
% g_max=double(max(max(rw)));
% g_min=double(min(min(rw)));
% T=round(g_max-(g_max-g_min)/2); % T 为二值化的阈值
% bw=(double(rw)>=T);  % d:二值图像
% bw = bwareaopen(bw, 200);
% bw=~bw; 
% imshow(bw);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw rw hanzi shuzizimu xiuzhenghanzi xiuzhengzimu xiuzhengzm_sz_1 xiuzhengzm_sz_2 xiuzhengshuzi_1 xiuzhengshuzi_2 xiuzhengshuzi_3
[y,x]=size(bw);
divimag=char_div(bw);
[m,k]=size(divimag);
char_1  =bw( 1:y,divimag(1):divimag(k-12));
char_2  =bw( 1:y,divimag(k-11):divimag(k-10));
char_3 =bw( 1:y,divimag(k-9):divimag(k-8));
char_4 =bw( 1:y,divimag(k-7):divimag(k-6));  
char_5 =bw( 1:y,divimag(k-5):divimag(k-4)); 
% imwrite(char_5,'timg.bmp');
char_6 =bw( 1:y,divimag(k-3):divimag(k-2)); 
char_7 =bw( 1:y,divimag(k-1):divimag(k)); 
xiuzhenghanzi =   imresize(char_1, [110 55],'bilinear');
xiuzhengzimu  =   imresize(char_2, [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(char_3,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(char_4,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(char_5,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(char_6,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(char_7,[110 55],'bilinear');

axes(handles.axes3);imshow(xiuzhenghanzi);
% imwrite(xiuzhenghanzi,'lu.bmp');
axes(handles.axes4);imshow(xiuzhengzimu);
axes(handles.axes5);imshow(xiuzhengzm_sz_1);
axes(handles.axes6);imshow(xiuzhengzm_sz_2);
axes(handles.axes7);imshow(xiuzhengshuzi_1);
axes(handles.axes8);imshow(xiuzhengshuzi_2);
axes(handles.axes9);imshow(xiuzhengshuzi_3);
%------------------------读取-----------------------------------
CP_gui=imread('gui.bmp');
CP_chuan=imread('chuan.bmp');
CP_lu=imread('lu.bmp');
CP_guizhou=imread('guizhou.bmp');
CP_JING=imread('JING.bmp');
CP_SU=imread('SU.bmp');
CP_YUE=imread('YUE.bmp');
hanzi(:,:,1)  =imresize(im2bw(CP_gui,graythresh(rgb2gray(CP_gui))),[110 55],'bilinear');
hanzi(:,:,2)  =imresize(im2bw(CP_chuan,graythresh(uint8(CP_chuan))),[110 55],'bilinear');
hanzi(:,:,3)  =imresize(im2bw(CP_lu,graythresh(uint8(CP_lu))),[110 55],'bilinear');
hanzi(:,:,4)  =imresize(im2bw(CP_guizhou,graythresh(rgb2gray(CP_guizhou))),[110 55],'bilinear');
hanzi(:,:,5)  =imresize(im2bw(CP_JING,graythresh(rgb2gray(CP_JING))),[110 55],'bilinear');
hanzi(:,:,6)  =imresize(im2bw(CP_SU,graythresh(rgb2gray(CP_SU))),[110 55],'bilinear');
hanzi(:,:,7)  =imresize(im2bw(CP_YUE,graythresh(rgb2gray(CP_YUE))),[110 55],'bilinear');
% hanzi=logical(hanzi);

s0=imread('0.bmp');s1=imread('1.bmp');s2=imread('2.bmp');s3=imread('3.bmp');s4=imread('4.bmp');s5=imread('5.bmp');s6=imread('6.bmp');s7=imread('7.bmp');
s8=imread('8.bmp');s9=imread('9.bmp');s10=imread('10.bmp');s11=imread('11.bmp');s12=imread('12.bmp');s13=imread('13.bmp');s14=imread('14.bmp');
s15=imread('15.bmp');s16=imread('16.bmp');s17=imread('17.bmp');s18=imread('18.bmp');s19=imread('19.bmp');s20=imread('20.bmp');s21=imread('21.bmp');
s22=imread('22.bmp');s23=imread('23.bmp');s24=imread('24.bmp');s25=imread('25.bmp');s26=imread('26.bmp');s27=imread('27.bmp');s28=imread('28.bmp');
s29=imread('29.bmp');s30=imread('30.bmp');s31=imread('31.bmp');s32=imread('32.bmp');s33=imread('33.bmp');
shuzizimu(:,:,1)   =imresize(im2bw(s0, graythresh(rgb2gray(s0))), [110 55],'bilinear');%利用这个阈值通常比人为设定的阈值能更好地把一张灰度图像转换为二值图像。
shuzizimu(:,:,2)   =imresize(im2bw(s1, graythresh(rgb2gray(s1))), [110 55],'bilinear');
shuzizimu(:,:,3)   =imresize(im2bw(s2, graythresh(rgb2gray(s2))), [110 55],'bilinear');
shuzizimu(:,:,4)   =imresize(im2bw(s3, graythresh(rgb2gray(s3))), [110 55],'bilinear');
shuzizimu(:,:,5)   =imresize(im2bw(s4, graythresh(rgb2gray(s4))), [110 55],'bilinear');
shuzizimu(:,:,6)   =imresize(im2bw(s5, graythresh(rgb2gray(s5))), [110 55],'bilinear');
shuzizimu(:,:,7)   =imresize(im2bw(s6, graythresh(rgb2gray(s6))), [110 55],'bilinear');
shuzizimu(:,:,8)   =imresize(im2bw(s7, graythresh(rgb2gray(s7))), [110 55],'bilinear');
shuzizimu(:,:,9)   =imresize(im2bw(s8, graythresh(rgb2gray(s8))), [110 55],'bilinear');
shuzizimu(:,:,10)  =imresize(im2bw(s9,graythresh(rgb2gray(s9))),[110 55],'bilinear');
shuzizimu(:,:,11)  =imresize(im2bw(s10,graythresh(rgb2gray(s10))),[110 55],'bilinear');
shuzizimu(:,:,12)  =imresize(im2bw(s11,graythresh(rgb2gray(s11))),[110 55],'bilinear');
shuzizimu(:,:,13)  =imresize(im2bw(s12,graythresh(rgb2gray(s12))),[110 55],'bilinear');
shuzizimu(:,:,14)  =imresize(im2bw(s13,graythresh(rgb2gray(s13))),[110 55],'bilinear');
shuzizimu(:,:,15)  =imresize(im2bw(s14,graythresh(rgb2gray(s14))),[110 55],'bilinear');
shuzizimu(:,:,16)  =imresize(im2bw(s15,graythresh(rgb2gray(s15))),[110 55],'bilinear');
shuzizimu(:,:,17)  =imresize(im2bw(s16,graythresh(rgb2gray(s16))),[110 55],'bilinear');
shuzizimu(:,:,18)  =imresize(im2bw(s17,graythresh(rgb2gray(s17))),[110 55],'bilinear');
shuzizimu(:,:,19)  =imresize(im2bw(s18,graythresh(rgb2gray(s18))),[110 55],'bilinear');
shuzizimu(:,:,20)  =imresize(im2bw(s19,graythresh(rgb2gray(s19))),[110 55],'bilinear');
shuzizimu(:,:,21)  =imresize(im2bw(s20,graythresh(rgb2gray(s20))),[110 55],'bilinear');
shuzizimu(:,:,22)  =imresize(im2bw(s21,graythresh(rgb2gray(s21))),[110 55],'bilinear');
shuzizimu(:,:,23)  =imresize(im2bw(s22,graythresh(rgb2gray(s22))),[110 55],'bilinear');
shuzizimu(:,:,24)  =imresize(im2bw(s23,graythresh(rgb2gray(s23))),[110 55],'bilinear');
shuzizimu(:,:,25)  =imresize(im2bw(s24,graythresh(rgb2gray(s24))),[110 55],'bilinear');
shuzizimu(:,:,26)  =imresize(im2bw(s25,graythresh(rgb2gray(s25))),[110 55],'bilinear');
shuzizimu(:,:,27)  =imresize(im2bw(s26,graythresh(rgb2gray(s26))),[110 55],'bilinear');
shuzizimu(:,:,28)  =imresize(im2bw(s27,graythresh(rgb2gray(s27))),[110 55],'bilinear');
shuzizimu(:,:,29)  =imresize(im2bw(s28,graythresh(uint8(s28))),[110 55],'bilinear');
shuzizimu(:,:,30)  =imresize(im2bw(s29,graythresh(rgb2gray(s29))),[110 55],'bilinear');
shuzizimu(:,:,31)  =imresize(im2bw(s30,graythresh(rgb2gray(s30))),[110 55],'bilinear');
shuzizimu(:,:,32)  =imresize(im2bw(s31,graythresh(rgb2gray(s31))),[110 55],'bilinear');
shuzizimu(:,:,33)  =imresize(im2bw(s32,graythresh(rgb2gray(s32))),[110 55],'bilinear');
shuzizimu(:,:,34)  =imresize(im2bw(s33,graythresh(rgb2gray(s33))),[110 55],'bilinear');
set(handles.pushbutton9,'Enable','on');
set(handles.pushbutton10,'Enable','off');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hanzi shuzizimu xiuzhenghanzi xiuzhengzimu xiuzhengzm_sz_1 xiuzhengzm_sz_2 xiuzhengshuzi_1 xiuzhengshuzi_2 xiuzhengshuzi_3 shibiejieguo
i=1;
Province_car=recog_word(hanzi,xiuzhenghanzi);shibiejieguo(1,i) =Province_car;  i=i+1;
jieguozimu   = recog_num(shuzizimu,xiuzhengzimu);     shibiejieguo(1,i) =jieguozimu;   i=i+1;
jieguozm_sz_1= recog_num(shuzizimu,xiuzhengzm_sz_1);  shibiejieguo(1,i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= recog_num(shuzizimu,xiuzhengzm_sz_2);  shibiejieguo(1,i) =jieguozm_sz_2;i=i+1;
jieguoshuzi_1= recog_num(shuzizimu,xiuzhengshuzi_1);  shibiejieguo(1,i) =jieguoshuzi_1;i=i+1;
jieguoshuzi_2= recog_num(shuzizimu,xiuzhengshuzi_2);  shibiejieguo(1,i) =jieguoshuzi_2;i=i+1;
jieguoshuzi_3= recog_num(shuzizimu,xiuzhengshuzi_3);      shibiejieguo(1,i) =jieguoshuzi_3;i=i+1;
 set(handles.edit1,'string',['车牌号码:',shibiejieguo]);
 set(handles.pushbutton10,'Enable','on');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_car
axes(handles.axes1),cla reset ;imshow('initial.jpg');
axes(handles.axes2),cla reset ;imshow('initial.jpg');
axes(handles.axes3),cla reset ;imshow('initial.jpg');
axes(handles.axes4),cla reset ;imshow('initial.jpg');
axes(handles.axes5),cla reset ;imshow('initial.jpg');
axes(handles.axes6),cla reset ;imshow('initial.jpg');
axes(handles.axes7),cla reset ;imshow('initial.jpg');
axes(handles.axes8),cla reset ;imshow('initial.jpg');
axes(handles.axes9),cla reset ;imshow('initial.jpg');
set(handles.edit1,'String','');
[filename,pathname]=uigetfile(...
                {'*.bmp;*.jpg;*.png;*.jpeg','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';... 
                              '*.*',             'AllFiles(*.*)'},...
                              'Pickanimage');
if isequal(filename,0)||isequal(pathname,0),
    return;
end
axes(handles.axes1);%用axes命令设置当前操作的坐标轴为oimage_axes
fpath=[pathname filename];
image_car = imread(fpath);
imshow(image_car);
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton5,'Enable','off');
set(handles.pushbutton8,'Enable','off');
set(handles.pushbutton9,'Enable','off');

% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_car
[filename,pathname]=uiputfile({'*.bmp','BMPfiles';'*.jpg;','JPGfiles'},'PickanImage'); 
if isequal(filename,0)||isequal(pathname,0) 
    return;%如果点了“取消”
else
    fpath=fullfile(pathname,filename);%获得全路径的另一种方法
end
img_src=image_car;
imwrite(img_src,fpath);%保存图片

% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(findobj('Tag','figure1'));%关闭主窗口


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shibiejieguo
fid=fopen('CarID.xls','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);

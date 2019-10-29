function varargout = ECG(varargin)
%ECG MATLAB code file for ECG.fig
%      ECG, by itself, creates a new ECG or raises the existing
%      singleton*.
%
%      H = ECG returns the handle to a new ECG or the handle to
%      the existing singleton*.
%
%      ECG('Property','Value',...) creates a new ECG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ECG_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ECG('CALLBACK') and ECG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ECG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECG

% Last Modified by GUIDE v2.5 01-May-2018 03:31:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECG_OpeningFcn, ...
                   'gui_OutputFcn',  @ECG_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

% --- Executes just before ECG is made visible.
function ECG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ECG
handles.output = hObject;
% % START USER CODE
% % Specify function handles for its start and run callbacks
set(handles.ecggraphtitle, 'String', 'ECG Waveform');

% handles.axesECG=axes;
% k=[-10,0.00001,10];
% SQ=k.^2;
% handles.SQ=SQ;

% % END USER CODE
% % Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ECG_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% function y = ECGsq(x)
%     y=x.^2;

% --- Executes on button press in StartECGbutton.
function StartECGbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StartECGbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 clear all;
fs=1e2;
t=[];
c=0;
s=serial('/dev/cu.usbmodem1411');
set(s,'BaudRate',9600);
fopen(s);
for i=1:12000
    T=str2num(fgetl(s));
    t=[t,T];
end
fclose(s);
g=length(t);
if mod(g,2) == 1
    g=g-1;
end
g=g/2;

for i=1:g
    c(i)=t(2*i-i)*5/1023.0;
end
e=(1:g)/100;
plot(handles.axesECG,e,c);
% a = arduino('/dev/cu.usbmodem1411','Uno');
% ECGline=line(nan, nan, 'color', 'red');
% 
% i=0;
% flag=0;
% interval=5000;
% x=zeros(1,5000); y=zeros(1,5000);
% Fs=1e3;
% 
% LP = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',150, ...
%        'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);
% HP = designfilt('highpassfir','FilterOrder',20,'CutoffFrequency',0.05, ...
%        'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs);
% 
% while (i<interval)
%     ECGn=readVoltage(a,'A1');
%     pause(0.1);
%     x=[x, i];
% %     ECGlp=filter(LP,ECGn);    %lowpass
% %     ECGhp=filter(HP,ECGlp);   %highpass
% %     ECGbsq=diff(ECGhp);        %differentiation
% %     ECGsqn=SQ(ECGbsq);       %squaring
% %     ECGc=integral(ECGsqn,-inf,+inf);  %integration
%     y=[y, ECGn];
%     xlabel('time [s]');
%     ylabel('Voltage [mV]');
%     grid minor;
%     set(ECGline, 'xData', x, 'yData', y);
%     grid on;
%     i=i+1;
%     pause(0.5);
%     if (flag==1)
%         break;
%     end
% end

    
    

% --- Executes on button press in BackECGButton.
function BackECGButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackECGButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
HomeScreen
close(ECG)


% --- Executes on button press in StopECGButton.
function StopECGButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopECGButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flag=1;

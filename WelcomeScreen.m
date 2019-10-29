function varargout = WelcomeScreen(varargin)
%WELCOMESCREEN MATLAB code file for WelcomeScreen.fig
%      WELCOMESCREEN, by itself, creates a new WELCOMESCREEN or raises the existing
%      singleton*.
%
%      H = WELCOMESCREEN returns the handle to a new WELCOMESCREEN or the handle to
%      the existing singleton*.
%
%      WELCOMESCREEN('Property','Value',...) creates a new WELCOMESCREEN using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to WelcomeScreen_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      WELCOMESCREEN('CALLBACK') and WELCOMESCREEN('CALLBACK',hObject,...) call the
%      local function named CALLBACK in WELCOMESCREEN.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WelcomeScreen

% Last Modified by GUIDE v2.5 13-Feb-2018 16:50:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WelcomeScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @WelcomeScreen_OutputFcn, ...
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


% --- Executes just before WelcomeScreen is made visible.
function WelcomeScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for WelcomeScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WelcomeScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WelcomeScreen_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartWelcomeButton.
function StartWelcomeButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartWelcomeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
HomeScreen
close(WelcomeScreen)

function varargout = imageLab(varargin)
% IMAGELAB MATLAB code for imageLab.fig
%      IMAGELAB, by itself, creates a new IMAGELAB or raises the existing
%      singleton*.
%
%      H = IMAGELAB returns the handle to a new IMAGELAB or the handle to
%      the existing singleton*.
%
%      IMAGELAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGELAB.M with the given input arguments.
%
%      IMAGELAB('Property','Value',...) creates a new IMAGELAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageLab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageLab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageLab

% Last Modified by GUIDE v2.5 15-Dec-2016 21:05:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageLab_OpeningFcn, ...
                   'gui_OutputFcn',  @imageLab_OutputFcn, ...
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


% --- Executes just before imageLab is made visible.
function imageLab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageLab (see VARARGIN)

% Choose default command line output for imageLab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageLab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageLab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in;
global out;
[filename, pathname] = uigetfile({'*.jpg';'*.png';'*tif'}, '载入图像');
imagePath = [pathname filename];
in = imread(imagePath);
str = get(handles.popupmenu1, 'String');
val = get(handles.popupmenu1,'Value');
set(handles.text1,'string', str{val});
if val == 1 % 阈值二值化
    set(handles.slider1, 'visible', 'on');
    set(handles.slider1, 'Value', 0.5);
else
    set(handles.slider1, 'visible', 'off');
end;
[grayIn, out] = processImage(in,str{val});
imshow(grayIn, 'parent',handles.axes1);
imshow(out, 'parent',handles.axes2);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global in;
global out;
str = get(hObject, 'String');
val = get(hObject,'Value');
set(handles.text1,'string', str{val});
if val == 1 % 阈值二值化
    set(handles.slider1, 'visible', 'on');
    set(handles.slider1, 'Value', 0.5);
else
    set(handles.slider1, 'visible', 'off');
end;
[grayIn, out] = processImage(in,str{val});
imshow(grayIn, 'parent',handles.axes1);
imshow(out, 'parent',handles.axes2);



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global in;
global out;
sliderValue = get(hObject,'Value');
% 二值化
out = im2bw(in, sliderValue);
imshow(out, 'parent',handles.axes2);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

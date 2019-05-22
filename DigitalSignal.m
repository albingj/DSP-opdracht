




function varargout = DigitalSignal(varargin)
% DIGITALSIGNAL MATLAB code for DigitalSignal.fig
%      DIGITALSIGNAL, by itself, creates a new DIGITALSIGNAL or raises the existing
%      singleton*.
%
%      H = DIGITALSIGNAL returns the handle to a new DIGITALSIGNAL or the handle to
%      the existing singleton*.
%
%      DIGITALSIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITALSIGNAL.M with the given input arguments.
%
%      DIGITALSIGNAL('Property','Value',...) creates a new DIGITALSIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DigitalSignal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DigitalSignal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DigitalSignal

% Last Modified by GUIDE v2.5 22-May-2019 17:35:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DigitalSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @DigitalSignal_OutputFcn, ...
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


function setData(Data)
global data;
data = Data;
assignin('base', 'data', data);


function Data = getData
global data;
Data = data;

function setSelectedData(Data)
global selectedData;
selectedData = Data;
assignin('base', 'selected',selectedData);


function Data = getSelectedData
global selectedData;
Data = selectedData;


function setTitles(Titles)
global titles;
titles = Titles;
assignin('base', 'titles', Titles);


function Titles = getTitles
global titles;
Titles = titles;

% --- Executes just before DigitalSignal is made visible.
function DigitalSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DigitalSignal (see VARARGIN)

% Choose default command line output for DigitalSignal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DigitalSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.uipanel2,'visible','off')
set(handles.uipanel1,'visible','on')
set(handles.pushbutton4,'visible','off')


% --- Outputs from this function are returned to the command line.
function varargout = DigitalSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in btnSelectData.
function btnSelectData_Callback(hObject, eventdata, handles)
 [file, path, index] = uigetfile({'*.xlsx';});
    
    if isequal(file, 0)
        %disp('User canceled file selection \r\n');
    else
        %disp('User selected file \r\n');
        FileSelected(fullfile(path, file), hObject, eventdata, handles);
    end
    
function FileSelected(fullpath, hObject, eventdata, handles)
    %disp(fullpath);
    
   [num, txt, raw] = xlsread(fullpath);
   % data = xlsread(fullpath, -1);
    
  
   
   beginKolom = 3;
   aantalKollomen = 6;
   rij = 13;
  titel = txt(rij, (beginKolom + (aantalKollomen * 0)));
  data = raw(rij+3:end-1, beginKolom:end);
  setData(data);
   %titel = txt(3, 15);
   %disp(raw(13,3));
   
   A = txt(13, :);
   A = A(~cellfun(@isempty, A));
   Q = split(A,":");
   A = Q(:,:,2) ;
   setTitles(A(1:22));
   
   guidata(hObject, handles);
   
   handles.listbox2.String = string(getTitles) ;
    handles.popupmenu1.String = string(getTitles); 
 
    
function [f,P1] = FourierBerekening(input) 
   Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 473;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = cell2mat(input);
n = 2^nextpow2(L);
pad = zeros( n-L,1);
S = [S;pad];
X = S.';
Y = fft(X,n);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;



% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtColumn_Callback(hObject, eventdata, handles)
% hObject    handle to txtColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtColumn as text
%        str2double(get(hObject,'String')) returns contents of txtColumn as a double


% --- Executes during object creation, after setting all properties.
function txtColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
listBoxItems = handles.listbox2.String;
listBoxSelectedIndexes = handles.listbox2.Value;
selectedString = listBoxItems{listBoxSelectedIndexes};
pos = ((listBoxSelectedIndexes-1)*6)+1;
pos2 = pos+5;
data = getData;
a = data(:,pos:pos2);
b = data(:,(pos+22):(pos2 +22));
c = data(:,(pos+44):(pos2 +44));
C = [a b c];
setSelectedData(C)
axes(handles.axes1);
t = cell2mat(C(:,1));
plot(t)
%hold on
%plot(cell2mat(C(:,7)))
%plot(cell2mat(C(:,13)))
%hold off
%plot(C);
 
Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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


function Callback(hObject, eventdata, handles)

data = getSelectedData


[x0,P] = FourierBerekening(data(:,1));
[y0,P1] = FourierBerekening(data(:,7));
[z0,P2] = FourierBerekening(data(:,13));

[x1,P3] = FourierBerekening(data(:,2)) ;
[y1,P4] = FourierBerekening(data(:,8)) ;
[z1,P5] = FourierBerekening(data(:,14));

[x2,P6] = FourierBerekening(data(:,3)) ;
[y2,P7] = FourierBerekening(data(:,9)) ;
[z2,P8] = FourierBerekening(data(:,15));

[x3,P9] = FourierBerekening(data(:,4)) ;
[y3,P10] = FourierBerekening(data(:,10)); 
[z3,P11] = FourierBerekening(data(:,16)) ;

[x4,P12] = FourierBerekening(data(:,5)) ;
[y4,P13] = FourierBerekening(data(:,11)) ;
[z4,P14] = FourierBerekening(data(:,17)) ;

[x5,P15] = FourierBerekening(data(:,6)) ;
[y5,P16] = FourierBerekening(data(:,12)) ;
[z5,P17] = FourierBerekening(data(:,18)) ;




%%View van paneel aanpassen-------------------
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
set(handles.uipanel2,'visible','off')
set(handles.uipanel1,'visible','on')
set(handles.pushbutton4,'visible','off')
set(handles.btnGesplitst,'visible','on')

% --- Executes on button press in btnGesplitst.
function btnGesplitst_Callback(hObject, eventdata, handles)

set(handles.uipanel2,'visible','on')
set(handles.uipanel1,'visible','off')
set(handles.pushbutton4,'visible','on')
set(handles.btnGesplitst,'visible','off')
% --- Executes on button press in btnGesplitst.


function radiobutton1_Callback(hObject, eventdata, handles)





% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)

data = getSelectedData;
switch(get(eventdata.NewValue,'Tag'))
    case 'radiobutton1'
        [x0,P] = FourierBerekening(data(:,1));
        [y0,P1] = FourierBerekening(data(:,7));
        [z0,P2] = FourierBerekening(data(:,13));
    case 'radiobutton2'
         [x0,P] = FourierBerekening(data(:,2));
        [y0,P1] = FourierBerekening(data(:,8));
        [z0,P2] = FourierBerekening(data(:,14));
        
    case 'radiobutton3'
          [x0,P] = FourierBerekening(data(:,3));
        [y0,P1] = FourierBerekening(data(:,9));
        [z0,P2] = FourierBerekening(data(:,15));
    case 'radiobutton4'
         [x0,P] = FourierBerekening(data(:,4));
        [y0,P1] = FourierBerekening(data(:,10));
        [z0,P2] = FourierBerekening(data(:,16));
        case 'radiobutton5'
         [x0,P] = FourierBerekening(data(:,5));
        [y0,P1] = FourierBerekening(data(:,11));
        [z0,P2] = FourierBerekening(data(:,17));
        case 'radiobutton6'
         [x0,P] = FourierBerekening(data(:,6));
        [y0,P1] = FourierBerekening(data(:,12));
        [z0,P2] = FourierBerekening(data(:,18));
end

axes(handles.axes2); plot(x0,P);
        axes(handles.axes3); plot(y0,P1)
        axes(handles.axes4); plot(z0,P2)





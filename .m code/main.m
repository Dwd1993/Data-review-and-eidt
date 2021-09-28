classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        DatabearbeitungUIFigure      matlab.ui.Figure
        GridLayout                   matlab.ui.container.GridLayout
        ImportButton                 matlab.ui.control.Button
        SuchenButton                 matlab.ui.control.Button
        InputButton                  matlab.ui.control.Button
        DeleteButton                 matlab.ui.control.Button
        ExportButton                 matlab.ui.control.Button
        UpdateButton                 matlab.ui.control.Button
        TabGroup                     matlab.ui.container.TabGroup
        RohdatenTab                  matlab.ui.container.Tab
        GridLayout2                  matlab.ui.container.GridLayout
        UITable                      matlab.ui.control.Table
        GefilterteDatenTab           matlab.ui.container.Tab
        GridLayout3                  matlab.ui.container.GridLayout
        UITable2                     matlab.ui.control.Table
        GridLayout4                  matlab.ui.container.GridLayout
        GridLayout5                  matlab.ui.container.GridLayout
        ContextMenu                  matlab.ui.container.ContextMenu
        AlleDatenlschenMenu          matlab.ui.container.Menu
        DatenmarkierungenlschenMenu  matlab.ui.container.Menu
    end

    
    properties (Access = private)
        DialogSuchen % Description
        selecteditem % Description
        suchedrow % Description
        suchedcol % Description
        suchitemsnum % Description
        Suchdialog % Description
        Inputdialog % Description
    end
    
    properties (Access = public)
        myTable %
    end
    

    
    methods (Access = public)
        
        function updatetable(app,suchvalue)
   
            a=zeros(size(app.myTable));
            removeStyle(app.UITable);

             for i=1:14
                 a(find(table2array(app.myTable(:,i+1))==suchvalue(i)),i)=1;
             end
            b=a>0
            sb=sum(b');
            bstr=suchvalue~=" ";
            strb=sum(bstr)
            if strb~=0
            app.suchitemsnum=strb;
            rowsb=find(sb==strb);
            colsb=find(bstr~=0)+1;
            if isempty(rowsb)
                 warndlg('Keine ergebnisse gefundenÿ', 'Warnung');
            end
              selectecolnum=ones([1,size(colsb,2)]);
              selectedcell(:,1)=kron(rowsb,selectecolnum)';
              selecteroes=repmat(colsb,1,size(rowsb,2))';
              selectedcell(:,2)=selecteroes;
                
            s = uistyle('BackgroundColor','yellow');
            s2 = uistyle('BackgroundColor','cyan');
            selet=uistyle('BackgroundColor','green');
            
            addStyle(app.UITable,s,'row',rowsb);
            addStyle(app.UITable,s2,'cell',selectedcell);
            if app.selecteditem~=[]
            addStyle(app.UITable,selet,'row',app.selecteditem);
            end
            app.suchedrow=rowsb;
            app.suchedcol=selectedcell;
            else
                app.suchitemsnum=0;
            end
            



        end
        
        function Adddata(app,data)
            oldtable=app.UITable.Data;
            newtable=[oldtable;data];
            app.UITable.Data=newtable;
            
        end
    end
    
    methods (Access = private)
        
 
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ImportButton
        function ImportButtonPushed(app, event)
            [file,path] = uigetfile('*.xlsm');
            if file==0
                
            else
            try Tabledata=readtable(fullfile(path,file),'Sheet','Simulationsbuch','Range','A:O','PreserveVariableNames',true);
                vartypes=string([1,size(Tabledata,2)]);
                for i=1:size(Tabledata,2)
                    vartypes{i}='string';
                end
                newT=table('Size',size(Tabledata),'VariableTypes',vartypes,'VariableNames',Tabledata.Properties.VariableNames);
                for n=1:size(Tabledata,1)
                    newT(n,:)=Tabledata(n,:);
                end
                app.myTable=newT;
                app.UITable.Data=newT;
                app.UITable.ColumnName=Tabledata.Properties.VariableNames;
                
            catch ME
                if(strcmp(ME.identifier,'MATLAB:spreadsheet:book:openSheetName'))
                warndlg('Es existiert kein Arbeitsblatt mit dem Namen Simulationsbuch, bitte überprüfen Sie, ob der Tabellenname korrekt ist!','Warnung');
                else                        
                    throw(ME);
                end
            end
            end
        end

        % Button pushed function: SuchenButton
        function SuchenButtonPushed(app, event)
            if isempty(app.UITable.Data)
                warndlg('Datei wurde nicht importiert', 'Warnung');
            else
            
            app.SuchenButton.Enable='off';
            app.Suchdialog=Suchenwindow(app,app.SuchenButton);
            end
        end

        % Cell selection callback: UITable
        function UITableCellSelection(app, event)

            removeStyle(app.UITable);
            indices = event.Indices;
            if ~isempty(indices)
            app.selecteditem=indices(1);
            if(~isempty(app.suchitemsnum) && ~isempty(app.suchedcol) && ~isempty(app.suchedrow))
            s = uistyle('BackgroundColor','yellow');
            s2 = uistyle('BackgroundColor','cyan');
  
            addStyle(app.UITable,s,'row',app.suchedrow);
            addStyle(app.UITable,s2,'cell',app.suchedcol);
            end
            selet=uistyle('BackgroundColor','green');
            addStyle(app.UITable,selet,'row',app.selecteditem);
            else
            end
            
    
             
             
            
            
            
            
        end

        % Button pushed function: DeleteButton
        function DeleteButtonPushed(app, event)
            
                selection=uiconfirm(app.DatabearbeitungUIFigure,'Ausgewählte Daten löschen?','Warnung',"Options",{'Ja','Nein'});
                if strcmp(selection,'Ja')
                    app.UITable.Data(app.selecteditem,:)=[];
                    
                end
            
        end

        % Close request function: DatabearbeitungUIFigure
        function DatabearbeitungUIFigureCloseRequest(app, event)
            selectioncon=uiconfirm(app.DatabearbeitungUIFigure,'Programm beendet?','Warnung',"Options",{'Ja','Cancel'});
            if strcmp(selectioncon,'Ja')
               delete(app.Suchdialog);
               delete(app.Inputdialog);
               delete(app);
            else
            end
 

          
            
            
        end

        % Button pushed function: InputButton
        function InputButtonPushed(app, event)
            app.Inputdialog=Inputwindow(app);
        end

        % Callback function
        function ModusButtonGroupSelectionChanged(app, event)
            selectedButton = app.ModusButtonGroup.SelectedObject;
            switch selectedButton.Text
                case 'Daten können bearbeitet werden'
                    app.UITable.ColumnEditable=true
                case 'Daten sind nicht editierbar'
                    app.UITable.ColumnEditable=false
            end
        end

        % Menu selected function: AlleDatenlschenMenu
        function AlleDatenlschenMenuSelected(app, event)
            selection=uiconfirm(app.DatabearbeitungUIFigure,'Alle Daten löschen?','Warnung',"Options",{'Ja','Nein'});
            if strcmp(selection,'Ja')
                    app.UITable.Data=[];
                    
            end
        end

        % Menu selected function: DatenmarkierungenlschenMenu
        function DatenmarkierungenlschenMenuSelected(app, event)
            app.suchedcol=[];
            app.suchedrow=[];
            removeStyle(app.UITable);
        end

        % Button pushed function: UpdateButton
        function UpdateButtonPushed(app, event)
            filterdata=app.UITable.Data(find(table2array(app.UITable.Data(:,5))=='Eintragung'),:);
            app.UITable2.Data=filterdata;
            app.UITable2.ColumnName=app.UITable.ColumnName;
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
            [file,path] = uiputfile('Exported_Data.xlsx');
            if file==0
            else
            path=fullfile([path,file])
            writetable(app.UITable.Data,path);
            end
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create DatabearbeitungUIFigure and hide until all components are created
            app.DatabearbeitungUIFigure = uifigure('Visible', 'off');
            app.DatabearbeitungUIFigure.Position = [100 100 970 719];
            app.DatabearbeitungUIFigure.Name = 'Data bearbeitung';
            app.DatabearbeitungUIFigure.CloseRequestFcn = createCallbackFcn(app, @DatabearbeitungUIFigureCloseRequest, true);
            app.DatabearbeitungUIFigure.HandleVisibility = 'on';
            app.DatabearbeitungUIFigure.WindowState = 'maximized';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.DatabearbeitungUIFigure);
            app.GridLayout.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x', '4.32x'};
            app.GridLayout.RowHeight = {'1x', 33, '5.87x'};

            % Create ImportButton
            app.ImportButton = uibutton(app.GridLayout, 'push');
            app.ImportButton.ButtonPushedFcn = createCallbackFcn(app, @ImportButtonPushed, true);
            app.ImportButton.IconAlignment = 'center';
            app.ImportButton.FontName = 'Arial';
            app.ImportButton.FontSize = 18;
            app.ImportButton.Layout.Row = 1;
            app.ImportButton.Layout.Column = 1;
            app.ImportButton.Text = 'Import';

            % Create SuchenButton
            app.SuchenButton = uibutton(app.GridLayout, 'push');
            app.SuchenButton.ButtonPushedFcn = createCallbackFcn(app, @SuchenButtonPushed, true);
            app.SuchenButton.FontName = 'Arial';
            app.SuchenButton.FontSize = 18;
            app.SuchenButton.Layout.Row = 1;
            app.SuchenButton.Layout.Column = 2;
            app.SuchenButton.Text = 'Suchen';

            % Create InputButton
            app.InputButton = uibutton(app.GridLayout, 'push');
            app.InputButton.ButtonPushedFcn = createCallbackFcn(app, @InputButtonPushed, true);
            app.InputButton.FontSize = 18;
            app.InputButton.Layout.Row = 1;
            app.InputButton.Layout.Column = 3;
            app.InputButton.Text = 'Input';

            % Create DeleteButton
            app.DeleteButton = uibutton(app.GridLayout, 'push');
            app.DeleteButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteButtonPushed, true);
            app.DeleteButton.FontSize = 18;
            app.DeleteButton.Layout.Row = 1;
            app.DeleteButton.Layout.Column = 4;
            app.DeleteButton.Text = 'Delete';

            % Create ExportButton
            app.ExportButton = uibutton(app.GridLayout, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.FontSize = 18;
            app.ExportButton.Layout.Row = 1;
            app.ExportButton.Layout.Column = 5;
            app.ExportButton.Text = 'Export';

            % Create UpdateButton
            app.UpdateButton = uibutton(app.GridLayout, 'push');
            app.UpdateButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.UpdateButton.FontSize = 18;
            app.UpdateButton.Layout.Row = 1;
            app.UpdateButton.Layout.Column = 6;
            app.UpdateButton.Text = 'Update';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.GridLayout);
            app.TabGroup.Layout.Row = [2 3];
            app.TabGroup.Layout.Column = [1 7];

            % Create RohdatenTab
            app.RohdatenTab = uitab(app.TabGroup);
            app.RohdatenTab.Title = 'Rohdaten';

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.RohdatenTab);
            app.GridLayout2.ColumnWidth = {'1x'};
            app.GridLayout2.RowHeight = {'1x', '2.5x'};
            app.GridLayout2.Padding = [1 10 1 10];

            % Create UITable
            app.UITable = uitable(app.GridLayout2);
            app.UITable.ColumnName = {''};
            app.UITable.RowName = {};
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.Layout.Row = [1 2];
            app.UITable.Layout.Column = 1;

            % Create GefilterteDatenTab
            app.GefilterteDatenTab = uitab(app.TabGroup);
            app.GefilterteDatenTab.Title = 'Gefilterte Daten';

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.GefilterteDatenTab);
            app.GridLayout3.ColumnWidth = {'1x', '1x', '1x', '1x'};
            app.GridLayout3.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};

            % Create UITable2
            app.UITable2 = uitable(app.GridLayout3);
            app.UITable2.ColumnName = {''};
            app.UITable2.RowName = {};
            app.UITable2.Layout.Row = [1 9];
            app.UITable2.Layout.Column = [1 4];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.GridLayout);
            app.GridLayout4.RowHeight = {'1x'};
            app.GridLayout4.Layout.Row = 1;
            app.GridLayout4.Layout.Column = 7;

            % Create GridLayout5
            app.GridLayout5 = uigridlayout(app.GridLayout4);
            app.GridLayout5.Layout.Row = 1;
            app.GridLayout5.Layout.Column = [1 2];

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.DatabearbeitungUIFigure);
            
            % Assign app.ContextMenu
            app.UITable.ContextMenu = app.ContextMenu;

            % Create AlleDatenlschenMenu
            app.AlleDatenlschenMenu = uimenu(app.ContextMenu);
            app.AlleDatenlschenMenu.MenuSelectedFcn = createCallbackFcn(app, @AlleDatenlschenMenuSelected, true);
            app.AlleDatenlschenMenu.ForegroundColor = [1 0 0];
            app.AlleDatenlschenMenu.Text = 'Alle Daten löschen';

            % Create DatenmarkierungenlschenMenu
            app.DatenmarkierungenlschenMenu = uimenu(app.ContextMenu);
            app.DatenmarkierungenlschenMenu.MenuSelectedFcn = createCallbackFcn(app, @DatenmarkierungenlschenMenuSelected, true);
            app.DatenmarkierungenlschenMenu.Text = 'Datenmarkierungen löschen';

            % Show the figure after all components are created
            app.DatabearbeitungUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.DatabearbeitungUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.DatabearbeitungUIFigure)
        end
    end
end
classdef Printsetup_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        ActiveprinterListBoxLabel  matlab.ui.control.Label
        ActiveprinterListBox       matlab.ui.control.ListBox
        PrintButton                matlab.ui.control.Button
        CancelButton               matlab.ui.control.Button
    end

    
    properties (Access = private)
        Inputdialog % Description
        toprintdata
        selectedprint
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, Printdatalog)
            app.Inputdialog=Printdatalog;
            app.toprintdata=app.Inputdialog.UITable.Data;
             Excel = actxserver('excel.application');
             Activep=Excel.ActivePrinter;
             Printlist{1}=Activep;

              app.ActiveprinterListBox.Items=Printlist;
          
        end

        % Button pushed function: PrintButton
        function PrintButtonPushed(app, event)
            try
                 delete("Need_Signature_Data.xls");
            filename = 'Need_Signature_Data.xls';
            writetable(app.toprintdata(1,1:2),filename,'Sheet',1);
             writetable(app.toprintdata(1,3:4),filename,'Sheet',1,"Range",'A3');
             writetable (app.toprintdata(1,5:6),filename,'Sheet',1,'Range','A5');
             writetable (app.toprintdata(1,7:8),filename,'Sheet',1,'Range','A7');
             writetable (app.toprintdata(1,9:10),filename,'Sheet',1,'Range','A9');
             writetable (app.toprintdata(1,11:12),filename,'Sheet',1,'Range','A11');
             writetable (app.toprintdata(1,13:14),filename,'Sheet',1,'Range','A13');
             writetable (app.toprintdata(1,15),filename,'Sheet',1,'Range','A15');
             Excel = actxserver('excel.application');
             Excel.visible = 1;
             Workbooks = Excel.Workbooks;
             % Make Excel visible
             % Open Excel file
             currentFolder = pwd;
             
             Workbook=Workbooks.Open([currentFolder,'\',filename]);
             Excel.ActiveSheet.Range('A:Z').EntireRow.AutoFit;
            
             Excel.ActiveSheet.Range('A2:Z2').WrapText = true;
             Excel.ActiveSheet.Range('A4:Z4').WrapText = true;
             Excel.ActiveSheet.Range('A6:Z6').WrapText = true;
             Excel.ActiveSheet.Range('A8:Z8').WrapText = true;
             Excel.ActiveSheet.Range('A10:Z10').WrapText = true;
             Excel.ActiveSheet.Range('A12:Z12').WrapText = true;
             Excel.ActiveSheet.Range('A14:Z14').WrapText = true;
             Excel.ActiveSheet.Range('A16').WrapText = true;
             
             Excel.ActiveSheet.Columns.ColumnWidth=50;
             Excel.ActiveSheet.Range('A:Z').HorizontalAlignment = -4108; % center alignment
             Excel.ActiveSheet.Range('A:Z').VerticalAlignment = -4108; % center alignment
             Excel.ActiveSheet.Range('A:Z').Borders.LineStyle = 1; % continious line
             Excel.ActiveSheet.PageSetup.Orientation = 'xlLandscape'; 
             
             if isempty(app.selectedprint)
                 warndlg('Kein Drucker ausgewählt','Error');
             else
                 Excel.ActiveWorkbook.PrintOut(1,1,1,true,app.selectedprint);
             end
             

             
                
            catch ME
                if strcmp('MATLAB:table:write:FileOpenInAnotherProcess',ME.identifier)
                    warndlg('Excel Datei ist in Excel geöffnet, bitte schließen Sie Excel zuerst', 'Error');
                else
                    ME
                    warndlg(ME.identifier,'Error');
                end
                
            end
           
        end

        % Value changed function: ActiveprinterListBox
        function ActiveprinterListBoxValueChanged(app, event)
            app.selectedprint = app.ActiveprinterListBox.Value;
            
        end

        % Button pushed function: CancelButton
        function CancelButtonPushed(app, event)
            delete(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 305 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create ActiveprinterListBoxLabel
            app.ActiveprinterListBoxLabel = uilabel(app.UIFigure);
            app.ActiveprinterListBoxLabel.HorizontalAlignment = 'right';
            app.ActiveprinterListBoxLabel.Position = [117 434 76 22];
            app.ActiveprinterListBoxLabel.Text = 'Active printer';

            % Create ActiveprinterListBox
            app.ActiveprinterListBox = uilistbox(app.UIFigure);
            app.ActiveprinterListBox.Items = {};
            app.ActiveprinterListBox.ValueChangedFcn = createCallbackFcn(app, @ActiveprinterListBoxValueChanged, true);
            app.ActiveprinterListBox.Position = [38 76 233 352];
            app.ActiveprinterListBox.Value = {};

            % Create PrintButton
            app.PrintButton = uibutton(app.UIFigure, 'push');
            app.PrintButton.ButtonPushedFcn = createCallbackFcn(app, @PrintButtonPushed, true);
            app.PrintButton.Position = [38 15 100 22];
            app.PrintButton.Text = 'Print';

            % Create CancelButton
            app.CancelButton = uibutton(app.UIFigure, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.Position = [171 15 100 22];
            app.CancelButton.Text = 'Cancel';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Printsetup_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
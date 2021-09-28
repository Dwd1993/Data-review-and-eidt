classdef Inputwindow_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        DatenEintragenUIFigure  matlab.ui.Figure
        GridLayout              matlab.ui.container.GridLayout
        UITable                 matlab.ui.control.Table
        PrintButton             matlab.ui.control.Button
        InputButton             matlab.ui.control.Button
    end

    
    properties (Access = private)
        mainapp; % Description
        Printsetupdialog % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, mainapp)
            app.mainapp=mainapp;
            for i=1:15
                vartypes{i}='string'
            end
             ss=app.UITable.ColumnName'
            tables=table('Size',[1,15],'VariableTypes',vartypes,'VariableNames',ss);
            tables(1,:)=array2table(zeros([1,15]));
            app.UITable.Data=tables;
        end

        % Button pushed function: PrintButton
        function PrintButtonPushed(app, event)
            app.Printsetupdialog=Printsetup(app);
           
             
             
        end

        % Button pushed function: InputButton
        function InputButtonPushed(app, event)
            Adddata(app.mainapp,app.UITable.Data);
        end

        % Close request function: DatenEintragenUIFigure
        function DatenEintragenUIFigureCloseRequest(app, event)
            delete(app.Printsetupdialog);
            delete(app);
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create DatenEintragenUIFigure and hide until all components are created
            app.DatenEintragenUIFigure = uifigure('Visible', 'off');
            app.DatenEintragenUIFigure.Position = [100 100 640 452];
            app.DatenEintragenUIFigure.Name = 'Daten Eintragen';
            app.DatenEintragenUIFigure.CloseRequestFcn = createCallbackFcn(app, @DatenEintragenUIFigureCloseRequest, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.DatenEintragenUIFigure);
            app.GridLayout.ColumnWidth = {'1x', '1.02x'};
            app.GridLayout.RowHeight = {'1x', '1.67x', '0.3x'};

            % Create UITable
            app.UITable = uitable(app.GridLayout);
            app.UITable.ColumnName = {'EKS'; 'Datum Antrag'; 'Grund für Simulation'; 'Anlass'; 'Simulationsort'; 'Simulations-ID'; 'Baustein/Anschlusspin'; 'Simulationswert'; 'Zusammenhänge/Risiken'; 'Bemerkung'; 'Datum Änderung/Ein-/Austragung der Simulation'; 'Uhrzeit Änderung/Ein-/Austragung der Simulation'; 'angewiesen durch'; 'durchgeführt durch'; 'Markierung'};
            app.UITable.RowName = {};
            app.UITable.ColumnSortable = true;
            app.UITable.ColumnEditable = true;
            app.UITable.Layout.Row = [1 2];
            app.UITable.Layout.Column = [1 2];

            % Create PrintButton
            app.PrintButton = uibutton(app.GridLayout, 'push');
            app.PrintButton.ButtonPushedFcn = createCallbackFcn(app, @PrintButtonPushed, true);
            app.PrintButton.FontSize = 18;
            app.PrintButton.Layout.Row = 3;
            app.PrintButton.Layout.Column = 1;
            app.PrintButton.Text = 'Print';

            % Create InputButton
            app.InputButton = uibutton(app.GridLayout, 'push');
            app.InputButton.ButtonPushedFcn = createCallbackFcn(app, @InputButtonPushed, true);
            app.InputButton.FontSize = 18;
            app.InputButton.Layout.Row = 3;
            app.InputButton.Layout.Column = 2;
            app.InputButton.Text = 'Input';

            % Show the figure after all components are created
            app.DatenEintragenUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Inputwindow_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.DatenEintragenUIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.DatenEintragenUIFigure)
        end
    end
end
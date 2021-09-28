classdef Suchenwindow_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        SuchenUIFigure                  matlab.ui.Figure
        EKSEditFieldLabel               matlab.ui.control.Label
        EKSEditField                    matlab.ui.control.EditField
        DatumAntragEditFieldLabel       matlab.ui.control.Label
        DatumAntragEditField            matlab.ui.control.EditField
        GrundfrSimulationEditFieldLabel  matlab.ui.control.Label
        GrundfrSimulationEditField      matlab.ui.control.EditField
        AnlassEditFieldLabel            matlab.ui.control.Label
        AnlassEditField                 matlab.ui.control.EditField
        SimulationsortEditFieldLabel    matlab.ui.control.Label
        SimulationsortEditField         matlab.ui.control.EditField
        SimulationsIDEditFieldLabel     matlab.ui.control.Label
        SimulationsIDEditField          matlab.ui.control.EditField
        ZusammenhngeRisikenEditFieldLabel  matlab.ui.control.Label
        ZusammenhngeRisikenEditField    matlab.ui.control.EditField
        BemerkungEditFieldLabel         matlab.ui.control.Label
        BemerkungEditField              matlab.ui.control.EditField
        DatumnderungEinAustragungderSimulationEditFieldLabel  matlab.ui.control.Label
        DatumnderungEinAustragungderSimulationEditField  matlab.ui.control.EditField
        UhrzeitnderungEinAustragungderSimulationEditFieldLabel  matlab.ui.control.Label
        UhrzeitnderungEinAustragungderSimulationEditField  matlab.ui.control.EditField
        angewiesendurchEditFieldLabel   matlab.ui.control.Label
        angewiesendurchEditField        matlab.ui.control.EditField
        durchgefhrtdurchEditFieldLabel  matlab.ui.control.Label
        durchgefhrtdurchEditField       matlab.ui.control.EditField
        BausteinAnschlusspinEditFieldLabel  matlab.ui.control.Label
        BausteinAnschlusspinEditField   matlab.ui.control.EditField
        MarkierungEditFieldLabel        matlab.ui.control.Label
        MarkierungEditField             matlab.ui.control.EditField
        SimulationswertEditFieldLabel   matlab.ui.control.Label
        SimulationswertEditField        matlab.ui.control.EditField
        SuchenButton                    matlab.ui.control.Button
        ClearButton                     matlab.ui.control.Button
    end

    
    properties (Access = private)
        mainapp % Description
        suchbtn;
    end
    
    
    methods (Access = public)
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, mainapp, suchbtn)
            app.mainapp=mainapp;
            app.suchbtn=suchbtn;
        end

        % Button pushed function: ClearButton
        function ClearButtonPushed(app, event)
            Alleidtedfileds=app.SuchenUIFigure.Children;
            for i=1:size(Alleidtedfileds,1)
                 if isa(Alleidtedfileds(i), 'matlab.ui.control.EditField')
                     set(Alleidtedfileds(i),'Value','');
                 end
            end
            
        end

        % Button pushed function: SuchenButton
        function SuchenButtonPushed(app, event)
            suchvalue=strings([1,15]);
            for i=1:15
                Alleidtedfileds=app.SuchenUIFigure.Children;
            for n=1:size(Alleidtedfileds,1)
                 if (isa(Alleidtedfileds(n),  'matlab.ui.control.EditField') && str2num(get(Alleidtedfileds(n),'Tag'))==i)
                     if (isempty(get(Alleidtedfileds(n),'Value')))
                         suchvalue(1,i)=' ';
                     else
                         suchvalue(1,i)=string(get(Alleidtedfileds(n),'Value'));
                     end
                     
                 end
               
            end
            end
           
           updatetable(app.mainapp,suchvalue);
        end

        % Close request function: SuchenUIFigure
        function SuchenUIFigureCloseRequest(app, event)
            app.suchbtn.Enable='on';
            delete(app);
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create SuchenUIFigure and hide until all components are created
            app.SuchenUIFigure = uifigure('Visible', 'off');
            app.SuchenUIFigure.Position = [100 100 664 480];
            app.SuchenUIFigure.Name = 'Suchen';
            app.SuchenUIFigure.CloseRequestFcn = createCallbackFcn(app, @SuchenUIFigureCloseRequest, true);
            app.SuchenUIFigure.HandleVisibility = 'on';
            app.SuchenUIFigure.Tag = 'suchenwin';

            % Create EKSEditFieldLabel
            app.EKSEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.EKSEditFieldLabel.HorizontalAlignment = 'right';
            app.EKSEditFieldLabel.Position = [123 433 30 22];
            app.EKSEditFieldLabel.Text = {'EKS'; ''};

            % Create EKSEditField
            app.EKSEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.EKSEditField.Tag = '1';
            app.EKSEditField.Position = [168 433 100 22];

            % Create DatumAntragEditFieldLabel
            app.DatumAntragEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.DatumAntragEditFieldLabel.HorizontalAlignment = 'right';
            app.DatumAntragEditFieldLabel.Position = [73 393 80 22];
            app.DatumAntragEditFieldLabel.Text = {'Datum Antrag'; ''};

            % Create DatumAntragEditField
            app.DatumAntragEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.DatumAntragEditField.Tag = '2';
            app.DatumAntragEditField.Position = [168 393 100 22];

            % Create GrundfrSimulationEditFieldLabel
            app.GrundfrSimulationEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.GrundfrSimulationEditFieldLabel.HorizontalAlignment = 'right';
            app.GrundfrSimulationEditFieldLabel.Position = [37 353 116 22];
            app.GrundfrSimulationEditFieldLabel.Text = {'Grund für Simulation'; ''};

            % Create GrundfrSimulationEditField
            app.GrundfrSimulationEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.GrundfrSimulationEditField.Tag = '3';
            app.GrundfrSimulationEditField.Position = [168 353 100 22];

            % Create AnlassEditFieldLabel
            app.AnlassEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.AnlassEditFieldLabel.HorizontalAlignment = 'right';
            app.AnlassEditFieldLabel.Position = [111 311 42 22];
            app.AnlassEditFieldLabel.Text = {'Anlass'; ''};

            % Create AnlassEditField
            app.AnlassEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.AnlassEditField.Tag = '4';
            app.AnlassEditField.Position = [168 311 100 22];

            % Create SimulationsortEditFieldLabel
            app.SimulationsortEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.SimulationsortEditFieldLabel.HorizontalAlignment = 'right';
            app.SimulationsortEditFieldLabel.Position = [71 264 82 22];
            app.SimulationsortEditFieldLabel.Text = {'Simulationsort'; ''};

            % Create SimulationsortEditField
            app.SimulationsortEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.SimulationsortEditField.Tag = '5';
            app.SimulationsortEditField.Position = [168 264 100 22];

            % Create SimulationsIDEditFieldLabel
            app.SimulationsIDEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.SimulationsIDEditFieldLabel.HorizontalAlignment = 'right';
            app.SimulationsIDEditFieldLabel.Position = [69 221 84 22];
            app.SimulationsIDEditFieldLabel.Text = {'Simulations-ID'; ''};

            % Create SimulationsIDEditField
            app.SimulationsIDEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.SimulationsIDEditField.Tag = '6';
            app.SimulationsIDEditField.Position = [168 221 100 22];

            % Create ZusammenhngeRisikenEditFieldLabel
            app.ZusammenhngeRisikenEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.ZusammenhngeRisikenEditFieldLabel.HorizontalAlignment = 'right';
            app.ZusammenhngeRisikenEditFieldLabel.Position = [297 433 142 22];
            app.ZusammenhngeRisikenEditFieldLabel.Text = {'Zusammenhänge/Risiken'; ''};

            % Create ZusammenhngeRisikenEditField
            app.ZusammenhngeRisikenEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.ZusammenhngeRisikenEditField.Tag = '9';
            app.ZusammenhngeRisikenEditField.Position = [454 433 100 22];

            % Create BemerkungEditFieldLabel
            app.BemerkungEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.BemerkungEditFieldLabel.HorizontalAlignment = 'right';
            app.BemerkungEditFieldLabel.Position = [372 393 67 22];
            app.BemerkungEditFieldLabel.Text = {'Bemerkung'; ''};

            % Create BemerkungEditField
            app.BemerkungEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.BemerkungEditField.Tag = '10';
            app.BemerkungEditField.Position = [454 393 100 22];

            % Create DatumnderungEinAustragungderSimulationEditFieldLabel
            app.DatumnderungEinAustragungderSimulationEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.DatumnderungEinAustragungderSimulationEditFieldLabel.HorizontalAlignment = 'right';
            app.DatumnderungEinAustragungderSimulationEditFieldLabel.Position = [73 69 269 22];
            app.DatumnderungEinAustragungderSimulationEditFieldLabel.Text = {'Datum Änderung/Ein-/Austragung der Simulation'; ''};

            % Create DatumnderungEinAustragungderSimulationEditField
            app.DatumnderungEinAustragungderSimulationEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.DatumnderungEinAustragungderSimulationEditField.Tag = '11';
            app.DatumnderungEinAustragungderSimulationEditField.Position = [357 69 100 22];

            % Create UhrzeitnderungEinAustragungderSimulationEditFieldLabel
            app.UhrzeitnderungEinAustragungderSimulationEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.UhrzeitnderungEinAustragungderSimulationEditFieldLabel.HorizontalAlignment = 'right';
            app.UhrzeitnderungEinAustragungderSimulationEditFieldLabel.Position = [73 35 271 22];
            app.UhrzeitnderungEinAustragungderSimulationEditFieldLabel.Text = {'Uhrzeit Änderung/Ein-/Austragung der Simulation'; ''};

            % Create UhrzeitnderungEinAustragungderSimulationEditField
            app.UhrzeitnderungEinAustragungderSimulationEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.UhrzeitnderungEinAustragungderSimulationEditField.Tag = '12';
            app.UhrzeitnderungEinAustragungderSimulationEditField.Position = [359 35 100 22];

            % Create angewiesendurchEditFieldLabel
            app.angewiesendurchEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.angewiesendurchEditFieldLabel.HorizontalAlignment = 'right';
            app.angewiesendurchEditFieldLabel.Position = [333 353 103 22];
            app.angewiesendurchEditFieldLabel.Text = {'angewiesen durch'; ''};

            % Create angewiesendurchEditField
            app.angewiesendurchEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.angewiesendurchEditField.Tag = '13';
            app.angewiesendurchEditField.Position = [454 353 100 22];

            % Create durchgefhrtdurchEditFieldLabel
            app.durchgefhrtdurchEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.durchgefhrtdurchEditFieldLabel.HorizontalAlignment = 'right';
            app.durchgefhrtdurchEditFieldLabel.Position = [333 305 106 22];
            app.durchgefhrtdurchEditFieldLabel.Text = {'durchgeführt durch'; ''};

            % Create durchgefhrtdurchEditField
            app.durchgefhrtdurchEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.durchgefhrtdurchEditField.Tag = '14';
            app.durchgefhrtdurchEditField.Position = [454 305 100 22];

            % Create BausteinAnschlusspinEditFieldLabel
            app.BausteinAnschlusspinEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.BausteinAnschlusspinEditFieldLabel.HorizontalAlignment = 'right';
            app.BausteinAnschlusspinEditFieldLabel.Position = [27 172 126 22];
            app.BausteinAnschlusspinEditFieldLabel.Text = {'Baustein/Anschlusspin'; ''};

            % Create BausteinAnschlusspinEditField
            app.BausteinAnschlusspinEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.BausteinAnschlusspinEditField.Tag = '7';
            app.BausteinAnschlusspinEditField.Position = [168 172 100 22];

            % Create MarkierungEditFieldLabel
            app.MarkierungEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.MarkierungEditFieldLabel.HorizontalAlignment = 'right';
            app.MarkierungEditFieldLabel.Position = [373 264 66 22];
            app.MarkierungEditFieldLabel.Text = {'Markierung'; ''};

            % Create MarkierungEditField
            app.MarkierungEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.MarkierungEditField.Tag = '15';
            app.MarkierungEditField.Position = [454 264 100 22];

            % Create SimulationswertEditFieldLabel
            app.SimulationswertEditFieldLabel = uilabel(app.SuchenUIFigure);
            app.SimulationswertEditFieldLabel.HorizontalAlignment = 'right';
            app.SimulationswertEditFieldLabel.Position = [63 125 90 22];
            app.SimulationswertEditFieldLabel.Text = {'Simulationswert'; ''};

            % Create SimulationswertEditField
            app.SimulationswertEditField = uieditfield(app.SuchenUIFigure, 'text');
            app.SimulationswertEditField.Tag = '8';
            app.SimulationswertEditField.Position = [168 125 100 22];

            % Create SuchenButton
            app.SuchenButton = uibutton(app.SuchenUIFigure, 'push');
            app.SuchenButton.ButtonPushedFcn = createCallbackFcn(app, @SuchenButtonPushed, true);
            app.SuchenButton.FontSize = 18;
            app.SuchenButton.Position = [445 205 118 29];
            app.SuchenButton.Text = 'Suchen';

            % Create ClearButton
            app.ClearButton = uibutton(app.SuchenUIFigure, 'push');
            app.ClearButton.ButtonPushedFcn = createCallbackFcn(app, @ClearButtonPushed, true);
            app.ClearButton.FontSize = 18;
            app.ClearButton.Position = [445 168 116 29];
            app.ClearButton.Text = 'Clear';

            % Show the figure after all components are created
            app.SuchenUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Suchenwindow_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.SuchenUIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.SuchenUIFigure)
        end
    end
end
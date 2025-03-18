% addpath('C:/dynare/6.3/matlab/')
% addpath('C:/Users/zacha/Documents/2025 Spring/Corporate Finance/Dean/PS1/')

% Code to run frictionless adjustment model in dynare
%dynare frictionless_model.mod
dynare endogenous_sdf_friction.mod

% Look in the oo object for the simulations
% Get Results
irfs = struct2cell(oo_.irfs);
irf_per = length(transpose(irfs{1,:}));
for i = 1:length(oo_.var_list) % For each defined variable 
    eval(['ss_' oo_.var_list{i} '= oo_.steady_state(i);']) % Take out the steady state value
    eval(['irf_' oo_.var_list{i} '= transpose(irfs{i,:})/oo_.steady_state(i);']) % reqrite IRFs in percent deviation terms
    eval(['sim_' oo_.var_list{i} '= transpose(oo_.endo_simul(i,:));']) % Take out the simulated paths
end

% Plot IRFs
fig(1) = figure(1);
for ii = 1:6
    subplot(2,3,ii)
    box on
    grid on
    hold on
    plot(1:irf_per,transpose(irfs{ii,:})/oo_.steady_state(ii), 'LineWidth',2,'Color','k')
    
    title(oo_.var_list{ii},'FontSize',15,'FontWeight','normal')
    set(gca,'FontSize',15,'XLim',[1 irf_per])
    xlabel('Time','FontSize',15) 
    ylabel('Percent Deviation from S.S.','FontSize',15) 
end
set(fig(1),'PaperOrientation','Landscape');
set(fig(1),'PaperPosition',[0 0 11 8.5]);
% print(fig(1),'-depsc','irfs_hayashi_noadjustment.eps');
print(fig(1),'-dpdf','irfs_hayashi_noadjustment.pdf');
% close all 

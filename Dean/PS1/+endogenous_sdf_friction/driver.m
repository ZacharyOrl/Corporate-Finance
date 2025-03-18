%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clearvars -global
clear_persistent_variables(fileparts(which('dynare')), false)
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info
options_ = [];
M_.fname = 'endogenous_sdf_friction';
M_.dynare_version = '6.3';
oo_.dynare_version = '6.3';
options_.dynare_version = '6.3';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'eps_z'};
M_.exo_names_tex(1) = {'eps\_z'};
M_.exo_names_long(1) = {'eps_z'};
M_.endo_names = cell(6,1);
M_.endo_names_tex = cell(6,1);
M_.endo_names_long = cell(6,1);
M_.endo_names(1) = {'k'};
M_.endo_names_tex(1) = {'k'};
M_.endo_names_long(1) = {'k'};
M_.endo_names(2) = {'q'};
M_.endo_names_tex(2) = {'q'};
M_.endo_names_long(2) = {'q'};
M_.endo_names(3) = {'i'};
M_.endo_names_tex(3) = {'i'};
M_.endo_names_long(3) = {'i'};
M_.endo_names(4) = {'z'};
M_.endo_names_tex(4) = {'z'};
M_.endo_names_long(4) = {'z'};
M_.endo_names(5) = {'sdf'};
M_.endo_names_tex(5) = {'sdf'};
M_.endo_names_long(5) = {'sdf'};
M_.endo_names(6) = {'c'};
M_.endo_names_tex(6) = {'c'};
M_.endo_names_long(6) = {'c'};
M_.endo_partitions = struct();
M_.param_names = cell(7,1);
M_.param_names_tex = cell(7,1);
M_.param_names_long = cell(7,1);
M_.param_names(1) = {'theta'};
M_.param_names_tex(1) = {'theta'};
M_.param_names_long(1) = {'theta'};
M_.param_names(2) = {'r'};
M_.param_names_tex(2) = {'r'};
M_.param_names_long(2) = {'r'};
M_.param_names(3) = {'delta'};
M_.param_names_tex(3) = {'delta'};
M_.param_names_long(3) = {'delta'};
M_.param_names(4) = {'phi_0'};
M_.param_names_tex(4) = {'phi\_0'};
M_.param_names_long(4) = {'phi_0'};
M_.param_names(5) = {'rho_z'};
M_.param_names_tex(5) = {'rho\_z'};
M_.param_names_long(5) = {'rho_z'};
M_.param_names(6) = {'sigma_z'};
M_.param_names_tex(6) = {'sigma\_z'};
M_.param_names_long(6) = {'sigma_z'};
M_.param_names(7) = {'gamma'};
M_.param_names_tex(7) = {'gamma'};
M_.param_names_long(7) = {'gamma'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 7;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
M_.surprise_shocks = [];
M_.learnt_shocks = [];
M_.learnt_endval = [];
M_.heteroskedastic_shocks.Qvalue_orig = [];
M_.heteroskedastic_shocks.Qscale_orig = [];
M_.matched_irfs = {};
M_.matched_irfs_weights = {};
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.ramsey_policy = false;
options_.discretionary_policy = false;
M_.eq_nbr = 6;
M_.ramsey_orig_eq_nbr = 0;
M_.ramsey_orig_endo_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 1 4 0;
 0 5 10;
 0 6 11;
 2 7 12;
 0 8 13;
 3 9 0;]';
M_.nstatic = 0;
M_.nfwrd   = 3;
M_.npred   = 2;
M_.nboth   = 1;
M_.nsfwrd   = 4;
M_.nspred   = 3;
M_.ndynamic   = 6;
M_.dynamic_tmp_nbr = [4; 1; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , 'q' ;
  2 , 'name' , '2' ;
  3 , 'name' , 'i' ;
  4 , 'name' , 'c' ;
  5 , 'name' , 'z' ;
  6 , 'name' , 'sdf' ;
};
M_.mapping.k.eqidx = [1 2 3 4 ];
M_.mapping.q.eqidx = [1 2 ];
M_.mapping.i.eqidx = [1 2 3 4 ];
M_.mapping.z.eqidx = [2 4 5 ];
M_.mapping.sdf.eqidx = [2 6 ];
M_.mapping.c.eqidx = [4 6 ];
M_.mapping.eps_z.eqidx = [5 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.block_structure.time_recursive = false;
M_.block_structure.block(1).Simulation_Type = 1;
M_.block_structure.block(1).endo_nbr = 1;
M_.block_structure.block(1).mfs = 1;
M_.block_structure.block(1).equation = [ 5];
M_.block_structure.block(1).variable = [ 4];
M_.block_structure.block(1).is_linear = true;
M_.block_structure.block(1).NNZDerivatives = 2;
M_.block_structure.block(1).bytecode_jacob_cols_to_sparse = [1 2 ];
M_.block_structure.block(2).Simulation_Type = 8;
M_.block_structure.block(2).endo_nbr = 5;
M_.block_structure.block(2).mfs = 5;
M_.block_structure.block(2).equation = [ 3 4 2 1 6];
M_.block_structure.block(2).variable = [ 1 6 2 3 5];
M_.block_structure.block(2).is_linear = false;
M_.block_structure.block(2).NNZDerivatives = 18;
M_.block_structure.block(2).bytecode_jacob_cols_to_sparse = [1 2 6 7 8 9 10 13 14 15 ];
M_.block_structure.block(1).g1_sparse_rowval = int32([]);
M_.block_structure.block(1).g1_sparse_colval = int32([]);
M_.block_structure.block(1).g1_sparse_colptr = int32([]);
M_.block_structure.block(2).g1_sparse_rowval = int32([1 2 4 5 1 2 3 2 5 3 4 1 2 4 5 3 3 3 ]);
M_.block_structure.block(2).g1_sparse_colval = int32([1 1 1 2 6 6 6 7 7 8 8 9 9 9 10 13 14 15 ]);
M_.block_structure.block(2).g1_sparse_colptr = int32([1 4 5 5 5 5 8 10 12 15 16 16 16 17 18 19 ]);
M_.block_structure.variable_reordered = [ 4 1 6 2 3 5];
M_.block_structure.equation_reordered = [ 5 3 4 2 1 6];
M_.block_structure.incidence(1).lead_lag = -1;
M_.block_structure.incidence(1).sparse_IM = [
 1 1;
 3 1;
 4 1;
 5 4;
 6 6;
];
M_.block_structure.incidence(2).lead_lag = 0;
M_.block_structure.incidence(2).sparse_IM = [
 1 2;
 1 3;
 2 1;
 2 2;
 3 1;
 3 3;
 4 1;
 4 3;
 4 4;
 4 6;
 5 4;
 6 5;
 6 6;
];
M_.block_structure.incidence(3).lead_lag = 1;
M_.block_structure.incidence(3).sparse_IM = [
 2 2;
 2 3;
 2 4;
 2 5;
];
M_.block_structure.dyn_tmp_nbr = 3;
M_.state_var = [4 1 6 ];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(7, 1);
M_.endo_trends = struct('deflator', cell(6, 1), 'log_deflator', cell(6, 1), 'growth_factor', cell(6, 1), 'log_growth_factor', cell(6, 1));
M_.NNZDerivatives = [23; -1; -1; ];
M_.dynamic_g1_sparse_rowval = int32([1 3 4 5 6 2 3 4 1 2 1 3 4 4 5 6 4 6 2 2 2 2 5 ]);
M_.dynamic_g1_sparse_colval = int32([1 1 1 4 6 7 7 7 8 8 9 9 9 10 10 11 12 12 14 15 16 17 19 ]);
M_.dynamic_g1_sparse_colptr = int32([1 4 4 4 5 5 6 9 11 14 16 17 19 19 20 21 22 23 23 24 ]);
M_.lhs = {
'q'; 
'q'; 
'i'; 
'c'; 
'z'; 
'sdf'; 
};
M_.static_tmp_nbr = [3; 0; 0; 0; ];
M_.block_structure_stat.block(1).Simulation_Type = 3;
M_.block_structure_stat.block(1).endo_nbr = 1;
M_.block_structure_stat.block(1).mfs = 1;
M_.block_structure_stat.block(1).equation = [ 5];
M_.block_structure_stat.block(1).variable = [ 4];
M_.block_structure_stat.block(2).Simulation_Type = 1;
M_.block_structure_stat.block(2).endo_nbr = 1;
M_.block_structure_stat.block(2).mfs = 1;
M_.block_structure_stat.block(2).equation = [ 6];
M_.block_structure_stat.block(2).variable = [ 5];
M_.block_structure_stat.block(3).Simulation_Type = 6;
M_.block_structure_stat.block(3).endo_nbr = 3;
M_.block_structure_stat.block(3).mfs = 3;
M_.block_structure_stat.block(3).equation = [ 3 2 1];
M_.block_structure_stat.block(3).variable = [ 3 1 2];
M_.block_structure_stat.block(4).Simulation_Type = 1;
M_.block_structure_stat.block(4).endo_nbr = 1;
M_.block_structure_stat.block(4).mfs = 1;
M_.block_structure_stat.block(4).equation = [ 4];
M_.block_structure_stat.block(4).variable = [ 6];
M_.block_structure_stat.variable_reordered = [ 4 5 3 1 2 6];
M_.block_structure_stat.equation_reordered = [ 5 6 3 2 1 4];
M_.block_structure_stat.incidence.sparse_IM = [
 1 1;
 1 2;
 1 3;
 2 1;
 2 2;
 2 3;
 2 4;
 2 5;
 3 1;
 3 3;
 4 1;
 4 3;
 4 4;
 4 6;
 5 4;
 6 5;
];
M_.block_structure_stat.tmp_nbr = 1;
M_.block_structure_stat.block(1).g1_sparse_rowval = int32([1 ]);
M_.block_structure_stat.block(1).g1_sparse_colval = int32([1 ]);
M_.block_structure_stat.block(1).g1_sparse_colptr = int32([1 2 ]);
M_.block_structure_stat.block(2).g1_sparse_rowval = int32([]);
M_.block_structure_stat.block(2).g1_sparse_colval = int32([]);
M_.block_structure_stat.block(2).g1_sparse_colptr = int32([]);
M_.block_structure_stat.block(3).g1_sparse_rowval = int32([1 2 3 1 2 3 2 3 ]);
M_.block_structure_stat.block(3).g1_sparse_colval = int32([1 1 1 2 2 2 3 3 ]);
M_.block_structure_stat.block(3).g1_sparse_colptr = int32([1 4 7 9 ]);
M_.block_structure_stat.block(4).g1_sparse_rowval = int32([]);
M_.block_structure_stat.block(4).g1_sparse_colval = int32([]);
M_.block_structure_stat.block(4).g1_sparse_colptr = int32([]);
M_.static_g1_sparse_rowval = int32([1 2 3 4 1 2 1 2 3 4 2 4 5 2 6 4 ]);
M_.static_g1_sparse_colval = int32([1 1 1 1 2 2 3 3 3 3 4 4 4 5 5 6 ]);
M_.static_g1_sparse_colptr = int32([1 5 7 11 14 16 17 ]);
M_.params(1) = 0.7;
theta = M_.params(1);
M_.params(2) = 0.04;
r = M_.params(2);
M_.params(3) = 0.15;
delta = M_.params(3);
M_.params(4) = 0.01;
phi_0 = M_.params(4);
M_.params(5) = 0.7;
rho_z = M_.params(5);
M_.params(6) = 0.1;
sigma_z = M_.params(6);
M_.params(7) = 2.0;
gamma = M_.params(7);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(4) = 1;
oo_.steady_state(2) = 1;
oo_.steady_state(1) = (M_.params(1)/(M_.params(2)+M_.params(3)))^(1/(1-M_.params(1)));
oo_.steady_state(3) = M_.params(3)*oo_.steady_state(1);
oo_.steady_state(5) = 1/(1+M_.params(2));
oo_.steady_state(6) = oo_.steady_state(1)^M_.params(1)-oo_.steady_state(3);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (M_.params(6))^2;
steady;
oo_.dr.eigval = check(M_,options_,oo_);
set_dynare_seed(03242023);
options_.drop = 200;
options_.irf = 40;
options_.nodisplay = true;
options_.order = 1;
options_.periods = 2000;
var_list_ = {};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'oo_recursive_', '-append');
end
if exist('options_mom_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'endogenous_sdf_friction_results.mat'], 'options_mom_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end

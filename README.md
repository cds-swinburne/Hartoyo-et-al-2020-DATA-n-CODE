# Implementation of methods employed and datasets used in Hartoyo et al. (2020)
Alpha blocking, a phenomenon where the alpha rhythm is attenuated by attention to a visual, auditory, tactile or cognitive stimulus, is one of the most prominent features of human electroencephalography (EEG) signals. Here we identify a simple physiological mechanism by which opening of the eyes causes attenuation of the alpha rhythm. We fit a neural population model to EEG spectra from 82 subjects, each showing different degrees of alpha blocking upon opening of their eyes.  Although it is notoriously difficult to obtain reliable parameter estimates from the fitting of such multi-parameter nonlinear models, we show that, by regularizing the inferred parameter differences between eyes-closed and eyes-open states, we can reduce the uncertainties in these differences without significantly compromising fit quality. From this emerges a parsimonious explanation for the spectral changes between states: Just a single parameter, <img src="http://latex.codecogs.com/gif.latex?$p_{ei}$" border="0" />, corresponding to the strength of a tonic, excitatory input to the inhibitory population, is sufficient to explain the reduction in alpha rhythm upon opening of the eyes. We show how the differential increase in <img src="http://latex.codecogs.com/gif.latex?$p_{ei}$" border="0" /> across different subjects increases with the degree of alpha blocking. In contrast, other parameters show weak differential changes that do not scale with alpha rhythm attenuation. Thus most of the variation in alpha blocking across subjects can be attributed to the strength of a tonic afferent signal to the inhibitory cortical population, without any need to invoke oscillatory thalamic input or explicit thalamo-cortical feedback. 

A full description of the techniques is described in the following manuscript:

"<b>Inferring a simple mechanism for alpha-blocking by fitting a neural population model to EEG spectra</b>" by Agus Hartoyo, Peter Cadusch, David Liley, and Damien Hicks 

## Datasets

The "Datasets" folder contains the main and the most important datasets used and generated in Hartoyo et al. (2020)

```
82x2x73_alpha_blocking_spectra.mat : dataset of the 82 pairs of eyes-closed (EC) and eyes-open (EO) experimental spectra we fit the neural population model to
```

```
82_subject_indices.mat : mapping between indices and labels of the 82 selected subjects
```

```
82x100x32_unregularized_best_paramsets.mat : dataset of the 10% best parameter sets selected from 1000 unregularized PSO samples 
```

```
82x100x32_regularized_best_paramsets.mat : dataset of the 10% best parameter sets selected from 1000 regularized PSO samples (regularization parameter = 0.1) 
```

#### The order of the 22 physiological parameteres in the datasets: <br>
<p><img src="http://latex.codecogs.com/gif.latex?$\tau _{e}, \tau _{i}, \gamma _{e}, \gamma _{i}, \Gamma _{e}, \Gamma _{i}, N_{ee}^{\beta }, N_{ei}^{\beta }, N_{ie}^{\beta }, N_{ii}^{\beta }, p_{ee}, p_{ei}, h_{e}^{rest}, h_{i}^{rest}, h_{e}^{eq}, h_{i}^{eq}, S_{e}^{\max }, S_{i}^{\max }, \bar{\mu _{e}}, \bar{\mu _{i}}, {\sigma }_{e}, {\sigma }_{i}$" border="0" /></p>


## Code

The "Hartoyo et al. (2019) code" folder is a Matlab<sup>&reg;</sup> source code folder that provides implementation code along with supporting data required to reproduce the experimental results presented in Hartoyo et al. (2019).

### Setup
1.	Clone or download this repository 
2.	Access the "Hartoyo et al. (2019) code" folder using Matlab<sup>&reg;</sup>
3. Run methods and reproduce results/visualizations by executing the following Matlab<sup>&reg;</sup> commands

### Run PSO-based random sampling
```
RunPSObasedSampling;
```

### Run MCMC sampling
```
BaseSetup;
RunSequenceBase(S_c(indx_a,indx_f),freq(indx_f),prm,dev_a,psel,mparam);
```

### Plot figures
```
FigureSetup;
FiguresBase(fparam, [figtype]);
``` 

#### Input arguments:
   figtype = 1 -> spectral fits for selected subjects (default) <br>
   figtype = 2 -> single subject post and prior MCMC distributions <br>
   figtype = 3 -> KLD Box plots for all subjects <br>
   figtype = 4 -> parameter box plots for all subjects <br>
   figtype = 5 -> Hessian eigenvalues (selected subjects) <br>
   figtype = 6 -> Fisher Information eigenvalues (selected subjects) <br>
   figtype = 7 -> Hessian eigenvector kernel smoothed density plots (all subjects) <br>
   figtype = 8 -> Fisher matrix eigenvector angle density plots (all subjects) <br>
   figtype = 9 -> plot prior distributions of Eigen-directions <br>
   figtype = 10 -> plot fitted spectra and spectra at points shifted in eigen directions <br>
   figtype = 11 -> plot the time domain eeg comparisons <br>
   figtype = 12 -> plot pairwise parameter histograms <br>
   figtype = 13 -> plot eigenvector components <br>
   figtype = 14 -> plot of derivatives of gaussain wrt its parameters <br>
   figtype = 15 -> plot of direction cosine magnitudes <br>
   figtype = 16 -> plot correlation coefficients <br>







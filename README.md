# Implementation of methods employed and datasets used in Hartoyo et al. (2020)
Alpha blocking, a phenomenon where the alpha rhythm is attenuated by attention to a visual, auditory, tactile or cognitive stimulus, is one of the most prominent features of human electroencephalography (EEG) signals. Here we identify a simple physiological mechanism by which opening of the eyes causes attenuation of the alpha rhythm. We fit a neural population model to EEG spectra from 82 subjects, each showing different degrees of alpha blocking upon opening of their eyes.  Although it is notoriously difficult to obtain reliable parameter estimates from the fitting of such multi-parameter nonlinear models, we show that, by regularizing the inferred parameter differences between eyes-closed and eyes-open states, we can reduce the uncertainties in these differences without significantly compromising fit quality. From this emerges a parsimonious explanation for the spectral changes between states: Just a single parameter, <img src="http://latex.codecogs.com/gif.latex?$p_{ei}$" border="0" />, corresponding to the strength of a tonic, excitatory input to the inhibitory population, is sufficient to explain the reduction in alpha rhythm upon opening of the eyes. We show how the differential increase in <img src="http://latex.codecogs.com/gif.latex?$p_{ei}$" border="0" /> across different subjects increases with the degree of alpha blocking. In contrast, other parameters show weak differential changes that do not scale with alpha rhythm attenuation. Thus most of the variation in alpha blocking across subjects can be attributed to the strength of a tonic afferent signal to the inhibitory cortical population, without any need to invoke oscillatory thalamic input or explicit thalamo-cortical feedback. 

A full description of the techniques is described in the following manuscript:

"<b>Inferring a simple mechanism for alpha-blocking by fitting a neural population model to EEG spectra</b>" by Agus Hartoyo, Peter Cadusch, David Liley, and Damien Hicks 

## Datasets

The "Datasets" folder contains the main and the most important datasets used and generated in Hartoyo et al. (2020)

```
82x2x73_alpha_blocking_spectra.mat : dataset of the 82 pairs of eyes-closed (EC) and eyes-open (EO) 
experimental spectra we fit the neural population model to
```

```
82_subject_indices.mat : mapping between indices and labels of the 82 selected subjects
```

```
82x100x32_unregularized_best_paramsets.mat : dataset of the 10% best parameter sets selected from 
1000 unregularized PSO samples 
```

```
82x100x32_regularized_best_paramsets.mat : dataset of the 10% best parameter sets selected from 
1000 regularized PSO samples (regularization parameter = 0.1) 
```

#### The order of the 22 physiological parameteres in the datasets: <br>
<p><img src="http://latex.codecogs.com/gif.latex?$\tau _{e}(EC), \tau _{i}(EC), \gamma _{e}(EC), \gamma _{i}(EC), \Gamma _{e}(EC), \Gamma _{i}(EC), N_{ee}^{\beta }, N_{ei}^{\beta }, N_{ie}^{\beta }, N_{ii}^{\beta }, p_{ee}(EC), p_{ei}(EO), h_{e}^{rest}, h_{i}^{rest}, h_{e}^{eq}, h_{i}^{eq}$" border="0" /></p>
<p><img src="http://latex.codecogs.com/gif.latex?$S_{e}^{\max }, S_{i}^{\max }, \bar{\mu _{e}}, \bar{\mu _{i}}, {\sigma }_{e}, {\sigma }_{i}, \eta(EC), \tau _{e}(EO), \tau _{i}(EO), \gamma _{e}(EO), \gamma _{i}(EO), \Gamma _{e}(EO), \Gamma _{i}(EO), p_{ee}(EO), p_{ei}(EO), \eta(EO)$" border="0" /></p>



## Code

The "Hartoyo et al. (2019) code" folder is a Matlab<sup>&reg;</sup> source code folder that provides implementation code along with supporting data required to reproduce the experimental results presented in Hartoyo et al. (2019).

### Setup
1.	Clone or download this repository 
2.	Access the "Hartoyo-et-al-2020-DATA-n-CODE" folder using Matlab<sup>&reg;</sup>
3. Run methods and reproduce results/visualizations by executing the following Matlab<sup>&reg;</sup> commands

### Run PSO-based random sampling with unregularized fitting for the 82 subjects in EC and EO states
```
unregularized_EC_EO_best_paramsets = RunTwoStatePSOBasedSamplingFor82Subjects(0);
```

### Run PSO-based random sampling with regularized fitting for the 82 subjects in EC and EO states (regularization parameter = 0.1)
```
regularized_EC_EO_best_paramsets = RunTwoStatePSOBasedSamplingFor82Subjects(0.1);
```

### Plot figures
```
fparam = DataSetup;
ShowFigure(fparam, [figtype]);
``` 

#### Input arguments:
   figtype = 1 -> reproduce Fig 1 (Different subjects exhibit different degrees of alpha blocking upon opening of the eyes) <br>
   figtype = 2 -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 3 -> advise accessing "Posterior distributions for each parameter.ipynb" \n using Jupyter Notebook<sup>&reg;</sup> \n to plot Fig 3 (Posterior distributions for each parameter) <br>
   figtype = 4 -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 5 -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 'A' -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 'B' -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 'C' -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>
   figtype = 'D' -> reproduce Fig 2 (Regularized and unregularized best fits to EC and EO spectra) <br>'
   






# Efficient Structure-preserving Support Tensor Train Machine

This repository contains MATLAB files for the implementation of work proposed in the paper
 [Efficient Structure-preserving Support Tensor Train Machine](https://arxiv.org/pdf/2002.05079.pdf).

**Intro** 

The key novelty of our research is a stable and well explained Support Vector Machine (SVM) model for low-rank tensor
 input data that manifests much higher classification accuracy and banchmarked compared to other state-of-the-art methods.
 Our paper presents a general SVM framework using the Tensor-Train decomposition 
 along with the explanation, validation and importance of each stage of the proposed algorithm with a graphical illustration.



**Dataset**

Folder- dataset

* ADNI_first - fMRI dataset for Alzheimer disease 

* ADHD -  fMRI dataset for Attention Deficit Hyperactivity Disorder




**Setup**

Addpath 

1. Tensor Train Toolbox 
2. LIBSVM 


 
**Functions and Results**

Each folder presents results for each step of algorithm, presented in paper. 

* Folder - TT_KTT_code ([Result_TT_KTT.m](https://github.com/mpimd-csc/Efficient_STTM/blob/master/TT_KTT_code/MMKTT_code/result_TT_KTT.m))

<img src="https://github.com/mpimd-csc/Efficient_STTM/blob/master/Figures/first.png" width="200">


* Folder - TT_UoSVD_KTT_code ([Result_TT_UoSVD_KTT.m](https://github.com/mpimd-csc/Efficient_STTM/blob/master/TT_UoSVD_KTT_code/result_TT_UoSVD_KTT.m))

<img src="https://github.com/mpimd-csc/Efficient_STTM/blob/master/Figures/second.png" width="200">



* Folder - TT-CP_UoSVD_KTT_code ([final_results_TTCP_UoSVD_KTT.m](https://github.com/mpimd-csc/Efficient_STTM/blob/master/TT-CP_UoSVD_KTT_code/final_results_TTCP_UoSVD_KTT.m))

<img src="https://github.com/mpimd-csc/Efficient_STTM/blob/master/Figures/third.png" width="200">


*Folder - TTCP_MMK_code ([Mainfile_results.m](https://github.com/mpimd-csc/Efficient_STTM/blob/master/TTCP-MMK_code/Norm_equilirium_UoSVD_TTCP_KTT_code/Mainfile_results.m))

<img src="https://github.com/mpimd-csc/Efficient_STTM/blob/master/Figures/fourth.png" width="200">


Comparision of our method to state-of-the-art

<img src="https://github.com/mpimd-csc/Efficient_STTM/blob/master/Figures/Main_comp.png" width="400">




**Cite As**

If you use our work and codes for the further research then please cite the paper [[Efficient_STTM]](https://arxiv.org/pdf/2002.05079.pdf).
<details><summary> BibTeX </summary><pre>
@misc{kour2020efficient,
      title={Efficient Structure-preserving Support Tensor Train Machine}, 
      author={Kirandeep Kour and Sergey Dolgov and Martin Stoll and Peter Benner},
      year={2020},
      eprint={2002.05079},
      archivePrefix={arXiv},
      primaryClass={cs.LG}
}</pre></details>

If you have any query/suggestion, kindly write to [Kirandeep Kour](kour@mpi-magdeburg.mpg.de).

import type {ViewProps} from 'ViewPropTypes';
import type {HostComponent} from 'react-native';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import {Float} from "react-native/Libraries/Types/CodegenTypes";

export interface NativeProps extends ViewProps {
    stickyHeight: Float,
}

export default codegenNativeComponent<NativeProps>(
    'RNScrollView',
) as HostComponent<NativeProps>;

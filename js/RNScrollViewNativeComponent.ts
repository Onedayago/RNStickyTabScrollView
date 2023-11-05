import type {ViewProps} from 'ViewPropTypes';
import type {HostComponent} from 'react-native';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import {boolean, DirectEventHandler, Float} from "react-native/Libraries/Types/CodegenTypes";

type ScrollEvent = Readonly<{
    x: Float;
    y: Float;
}>;

export interface NativeProps extends ViewProps {
    stickyHeight: Float,
    contentHeight: Float,
    bounce: boolean,
    showsIndicator: boolean,
    width: Float,
    height: Float,
}

export default codegenNativeComponent<NativeProps>(
    'RNScrollView',
) as HostComponent<NativeProps>;
